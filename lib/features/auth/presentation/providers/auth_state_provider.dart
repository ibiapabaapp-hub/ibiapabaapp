import 'package:ibiapabaapp/core/logger/handlers/controller_log_handler.dart';
import 'package:ibiapabaapp/core/logger/log_tags.dart';
import 'package:ibiapabaapp/core/logger/logger.dart';
import 'package:ibiapabaapp/core/storage/token_storage_provider.dart';
import 'package:ibiapabaapp/features/auth/domain/entities/auth_result.dart';
import 'package:ibiapabaapp/features/auth/domain/entities/account.dart';
import 'package:ibiapabaapp/features/auth/presentation/providers/auth_providers.dart';
import 'package:ibiapabaapp/features/profiles/domain/entities/profile.dart';
import 'package:ibiapabaapp/features/profiles/presentation/providers/profile_state_provider.dart';
import 'package:ibiapabaapp/features/profiles/presentation/providers/profiles_providers.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_state_provider.g.dart';

@Riverpod(keepAlive: true)
class AuthState extends _$AuthState with ControllerLogHandler {
  @override
  late final Logger logger;

  @override
  LogFeature get feature => LogFeature.session;

  @override
  AuthData build() {
    logger = ref.read(loggerProvider);
    return const AuthData();
  }

  // TODO: refatorar para simplificar emaranhado de métodos
  Future<void> restore() async {
    await _restoreUser();
  }

  Future<void> _restoreUser() async {
    final tokenStorage = ref.read(tokenStorageProvider);
    final accessToken = await tokenStorage.getAccessToken();
    final refreshToken = await tokenStorage.getRefreshToken();

    if (accessToken == null || refreshToken == null) return;

    final getMeResult = await ref.read(getMeProvider).call();
    if (!ref.mounted) return;

    await getMeResult.fold(
      (failure) async {
        logControllerError(action: AppSessionAction.restore, failure: failure);

        final refreshResult = await ref.read(refreshTokensProvider).call();
        await refreshResult.fold(
          (_) async => logout(),
          (authResult) async => _applySession(authResult),
        );
      },
      (user) async {
        _applyAccount(user);
        await _loadAccountProfiles();
        await ref.read(profileStateProvider.notifier).restore();
        logControllerSuccess(action: AppSessionAction.restore);
      },
    );
  }

  Future<void> _loadAccountProfiles() async {
    final result = await ref.read(getAccountProfilesProvider).call();
    if (!ref.mounted) return;

    result.fold(
      (failure) => logControllerError(
        action: AppSessionAction.initSession,
        failure: failure,
      ),
      (profiles) async {
        logControllerSuccess(action: AppSessionAction.getAccountProfiles);
        _applyAccountProfiles(profiles);
      },
    );
  }

  void _applyAccountProfiles(List<Profile> profiles) {
    ref.read(profileStateProvider.notifier).setProfiles(profiles);
  }

  Future<void> initSession(AuthResult result) async {
    await ref.read(tokenStorageProvider).saveTokens(result);
    if (!ref.mounted) return;
    await _applySession(result);
    logControllerSuccess(action: AppSessionAction.initSession);
  }

  Future<void> _applySession(AuthResult result) async {
    _applyAccount(result.account);
    if (!ref.mounted) return;
  }

  void _applyAccount(Account account) {
    state = state.copyWith(account: account);
  }

  Future<void> logout() async {
    await ref.read(tokenStorageProvider).clearTokens();
    state = const AuthData();
    logControllerSuccess(action: AppSessionAction.logout);
  }
}

class AuthData {
  final Account? account;

  const AuthData({this.account});

  bool get isAuthenticated => account != null;

  AuthData copyWith({Account? account, Profile? activeProfile}) {
    return AuthData(account: account ?? this.account);
  }
}

@riverpod
bool isAuthenticated(Ref ref) {
  return ref.watch(authStateProvider).isAuthenticated;
}
