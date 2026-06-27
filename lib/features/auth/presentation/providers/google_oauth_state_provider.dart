import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ibivibe/core/errors/failures/failures.dart';
import 'package:ibivibe/core/logger/handlers/controller_log_handler.dart';
import 'package:ibivibe/core/logger/log_tags.dart';
import 'package:ibivibe/core/logger/logger.dart';
import 'package:ibivibe/shared/models/account_type.dart';
import 'package:ibivibe/shared/models/gender.dart';
import 'package:ibivibe/features/auth/domain/entities/auth_result.dart';
import 'package:ibivibe/features/auth/domain/entities/check_availability.dart';
import 'package:ibivibe/features/auth/domain/tags/auth_logtags.dart';
import 'package:ibivibe/features/auth/presentation/providers/auth_providers.dart';
import 'package:ibivibe/features/auth/presentation/providers/auth_state_provider.dart';
import 'package:ibivibe/features/auth/presentation/states/google_oauth_data_state.dart';
import 'package:ibivibe/shared/ui/forms/fields/email/email_checker.dart';
import 'package:ibivibe/shared/ui/forms/fields/slug/slug_checker.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'google_oauth_state_provider.g.dart';

@Riverpod(keepAlive: true)
class GoogleOAuthState extends _$GoogleOAuthState
    with ControllerLogHandler
    implements SlugChecker, EmailChecker {
  @override
  late final Logger logger = ref.read(loggerProvider);

  @override
  LogFeature get feature => LogFeature.auth;

  @override
  GoogleOAuthDataState build() => const GoogleOAuthDataState();

  void reset() {
    state = const GoogleOAuthDataState();
  }

  // ─── Submits ───────────────────────────────────────────────────────────────
  Future<bool> signInWithGoogle() async {
    state = state.copyWith(isLoading: true, failure: null);

    try {
      await GoogleSignIn.instance.initialize(
        clientId: _getClientId(),
        serverClientId: _getServerClientId(),
      );

      final GoogleSignInAccount account = await GoogleSignIn.instance
          .authenticate();

      final GoogleSignInAuthentication authentication = account.authentication;
      final String? idToken = authentication.idToken;

      if (idToken == null) {
        state = state.copyWith(
          isLoading: false,
          failure: const InternalFailure('Failed to get Google ID token'),
        );
        logControllerError(
          action: AuthAction.loginWithGoogle,
          failure: const InternalFailure('Failed to get Google ID token'),
        );
        return false;
      }

      final repository = ref.read(authRepositoryProvider);
      final googleAuthResult = await repository.loginWithGoogle(
        idToken: idToken,
      );

      if (googleAuthResult.isNewUser) {
        state = state.copyWith(
          isLoading: false,
          tempToken: googleAuthResult.tempToken,
          googleAuthResult: googleAuthResult,
        );
        logControllerSuccess(action: AuthAction.loginWithGoogle);
        return true;
      } else if (googleAuthResult.account != null &&
          googleAuthResult.accessToken != null &&
          googleAuthResult.refreshToken != null) {
        // Existing user - initialize session
        final authResult = AuthResult(
          accessToken: googleAuthResult.accessToken!,
          refreshToken: googleAuthResult.refreshToken!,
          account: googleAuthResult.account!,
        );
        ref.read(authStateProvider.notifier).initSession(authResult);
        state = state.copyWith(
          isLoading: false,
          googleAuthResult: googleAuthResult,
        );
        logControllerSuccess(action: AuthAction.loginWithGoogle);
        return false;
      } else {
        state = state.copyWith(
          isLoading: false,
          failure: const InternalFailure('Invalid Google auth response'),
        );
        logControllerError(
          action: AuthAction.loginWithGoogle,
          failure: const InternalFailure('Invalid Google auth response'),
        );
        return false;
      }
    } catch (e) {
      final message = e is AppFailure ? e.message : e.toString();
      state = state.copyWith(
        isLoading: false,
        failure: e is AppFailure ? e : InternalFailure(message),
      );
      logControllerError(
        action: AuthAction.loginWithGoogle,
        failure: e is AppFailure ? e : InternalFailure(message),
      );
      return false;
    }
  }

  Future<void> completeRegistration({
    required String slug,
    required AccountType type,
    Gender? gender,
  }) async {
    final tempToken = state.tempToken;
    if (tempToken == null) {
      state = state.copyWith(
        failure: const InternalFailure('No temp token found'),
      );
      return;
    }

    state = state.copyWith(isLoading: true, failure: null);

    try {
      final repository = ref.read(authRepositoryProvider);
      final response = await repository.completeGoogleRegistration(
        tempToken: tempToken,
        slug: slug,
        type: type,
        gender: gender,
      );

      final authResult = AuthResult(
        accessToken: response.accessToken,
        refreshToken: response.refreshToken,
        account: response.account,
      );
      await ref.read(authStateProvider.notifier).initSession(authResult);
      state = state.copyWith(
        isLoading: false,
        tempToken: null,
        googleAuthResult: null,
      );
      logControllerSuccess(action: AuthAction.completeGoogleRegistration);
    } catch (e) {
      final message = e is AppFailure ? e.message : e.toString();
      state = state.copyWith(
        isLoading: false,
        failure: e is AppFailure ? e : InternalFailure(message),
      );
      logControllerError(
        action: AuthAction.completeGoogleRegistration,
        failure: e is AppFailure ? e : InternalFailure(message),
      );
    }
  }

  // ─── Slug ──────────────────────────────────────────────────────────────────
  @override
  Future<bool> checkSlugAvailability(String slug) async {
    state = state.copyWith(slugAvailable: null, slugChecking: true);

    try {
      final repository = ref.read(authRepositoryProvider);
      final availabilityResult = await repository.checkAvailability(
        field: AvailabilityField.slug,
        value: slug,
      );

      if (!ref.mounted) return false;

      state = state.copyWith(
        slugAvailable: availabilityResult.available,
        slugChecking: false,
      );
      return availabilityResult.available;
    } catch (e) {
      if (!ref.mounted) return false;

      state = state.copyWith(slugAvailable: false, slugChecking: false);
      logControllerError(
        action: AuthAction.completeGoogleRegistration,
        failure: e is AppFailure ? e : InternalFailure(e.toString()),
      );
      return false;
    }
  }

  @override
  void setSlug(String slug) {
    state = state.copyWith(clearSlugStatus: true);
  }

  @override
  bool? isSlugAvailable() => state.slugAvailable;

  @override
  bool isSlugChecking() => state.slugChecking;

  // ─── Email ─────────────────────────────────────────────────────────────────
  @override
  Future<bool> checkEmailAvailability(String email) async {
    state = state.copyWith(emailAvailable: null, emailChecking: true);

    try {
      final repository = ref.read(authRepositoryProvider);
      final availabilityResult = await repository.checkAvailability(
        field: AvailabilityField.email,
        value: email,
      );

      if (!ref.mounted) return false;

      state = state.copyWith(
        emailAvailable: availabilityResult.available,
        emailChecking: false,
      );
      return availabilityResult.available;
    } catch (e) {
      if (!ref.mounted) return false;

      state = state.copyWith(emailAvailable: false, emailChecking: false);
      logControllerError(
        action: AuthAction.completeGoogleRegistration,
        failure: e is AppFailure ? e : InternalFailure(e.toString()),
      );
      return false;
    }
  }

  @override
  void setEmail(String email) {
    state = state.copyWith(clearEmailStatus: true);
  }

  @override
  bool? isEmailAvailable() => state.emailAvailable;

  @override
  bool isEmailChecking() => state.emailChecking;

  // ─── Helpers ───────────────────────────────────────────────────────────────
  String _getClientId() {
    return dotenv.env['GOOGLE_CLIENT_ID'] ?? '';
  }

  String _getServerClientId() {
    return dotenv.env['GOOGLE_CLIENT_ID_WEB'] ?? '';
  }
}
