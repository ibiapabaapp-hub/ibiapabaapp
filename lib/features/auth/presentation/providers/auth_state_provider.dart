import 'package:ibivibe/core/errors/failures/failures.dart';
import 'package:ibivibe/core/logger/handlers/controller_log_handler.dart';
import 'package:ibivibe/core/logger/log_tags.dart';
import 'package:ibivibe/core/logger/logger.dart';
import 'package:ibivibe/core/storage/token_storage_provider.dart';
import 'package:ibivibe/shared/providers/accounts_state_provider.dart';
import 'package:ibivibe/features/auth/domain/entities/auth_result.dart';
import 'package:ibivibe/features/auth/domain/tags/auth_logtags.dart';
import 'package:ibivibe/features/auth/presentation/providers/auth_providers.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_state_provider.g.dart';

@Riverpod(keepAlive: true)
class AuthState extends _$AuthState with ControllerLogHandler {
  @override
  late final Logger logger = ref.read(loggerProvider);

  @override
  LogFeature get feature => LogFeature.auth;

  @override
  AuthData build() => const AuthData();

  Future<void> restore() async {
    final tokenStorage = ref.read(tokenStorageProvider);
    final accessToken = await tokenStorage.getAccessToken();
    final refreshToken = await tokenStorage.getRefreshToken();

    if (accessToken == null || refreshToken == null) {
      ref.read(accountsStateProvider.notifier).markLoadingDone();
      return;
    }

    try {
      final repository = ref.read(authRepositoryProvider);
      final account = await repository.getMe();
      if (!ref.mounted) {
        ref.read(accountsStateProvider.notifier).markLoadingDone();
        return;
      }

      await ref.read(accountsStateProvider.notifier).onAuthSuccess(account);
      state = AuthData(
        activeAccountId: account.id,
        status: AuthStatus.verified,
      );
      logControllerSuccess(action: AuthAction.restore);
      return;
    } catch (e) {
      if (!ref.mounted) {
        ref.read(accountsStateProvider.notifier).markLoadingDone();
        return;
      }

      final failure = e is AppFailure ? e : InternalFailure(e.toString());
      logControllerError(action: AuthAction.restore, failure: failure);

      if (failure is NetworkFailure) {
        final cachedId = await ref
            .read(accountsStateProvider.notifier)
            .restoreFromCache();
        if (!ref.mounted) return;
        if (cachedId != null) {
          state = AuthData(
            activeAccountId: cachedId,
            status: AuthStatus.unverified,
          );
          logControllerSuccess(action: AuthAction.restoreFromCache);
        }
        return;
      }

      try {
        final repository = ref.read(authRepositoryProvider);
        final authResult = await repository.refreshTokens();
        if (!ref.mounted) {
          ref
              .read(accountsStateProvider.notifier)
              .markLoadingDone();
          return;
        }
        await initSession(authResult);
      } catch (_) {
        await logout();
      }
    }
  }

  Future<void> initSession(AuthResult result) async {
    final tokenStorage = ref.read(tokenStorageProvider);
    await tokenStorage.saveTokens(result);
    if (!ref.mounted) return;

    await ref
        .read(accountsStateProvider.notifier)
        .onAuthSuccess(result.account);
    if (!ref.mounted) return;

    state = AuthData(
      activeAccountId: result.account.id,
      status: AuthStatus.verified,
    );
    logControllerSuccess(action: AuthAction.initSession);
  }

  Future<void> logout() async {
    final tokenStorage = ref.read(tokenStorageProvider);
    final accountId = state.activeAccountId;

    await tokenStorage.clearTokens();
    if (!ref.mounted) return;

    if (accountId != null) {
      await ref.read(accountsStateProvider.notifier).onLogout(accountId);
    }

    state = const AuthData();
    logControllerSuccess(action: AuthAction.logout);
  }
}

enum AuthStatus {
  unauthenticated,
  verified,
  unverified,
}

class AuthData {
  final String? activeAccountId;
  final AuthStatus status;

  const AuthData({
    this.activeAccountId,
    this.status = AuthStatus.unauthenticated,
  });

  bool get isAuthenticated =>
      activeAccountId != null && status != AuthStatus.unauthenticated;
  bool get isVerified => status == AuthStatus.verified;

  AuthData copyWith({
    String? activeAccountId,
    AuthStatus? status,
    bool clear = false,
  }) {
    return AuthData(
      activeAccountId: clear ? null : (activeAccountId ?? this.activeAccountId),
      status: clear ? AuthStatus.unauthenticated : (status ?? this.status),
    );
  }
}

@riverpod
AuthStatus currentAuthStatus(Ref ref) {
  return ref.watch(authStateProvider).status;
}

@riverpod
bool isAuthenticated(Ref ref) {
  return ref.watch(authStateProvider).isAuthenticated;
}
