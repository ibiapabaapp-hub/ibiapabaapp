import 'package:ibivibe/core/errors/failures/failures.dart';
import 'package:ibivibe/core/logger/handlers/controller_log_handler.dart';
import 'package:ibivibe/core/logger/log_tags.dart';
import 'package:ibivibe/core/logger/logger.dart';
import 'package:ibivibe/core/preferences/user_preferences_state_provider.dart';
import 'package:ibivibe/features/auth/models/check_availability.dart';
import 'package:ibivibe/features/auth/auth_logtags.dart';
import 'package:ibivibe/features/auth/presentation/providers/auth_providers.dart';
import 'package:ibivibe/features/auth/presentation/providers/auth_state_provider.dart';
import 'package:ibivibe/features/auth/presentation/states/register_state.dart';
import 'package:ibivibe/features/auth/validation/auth_validator.dart';
import 'package:ibivibe/shared/ui/forms/fields/email/email_checker.dart';
import 'package:ibivibe/shared/ui/forms/fields/slug/slug_checker.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'register_controller.g.dart';

@riverpod
class RegisterController extends _$RegisterController
    with ControllerLogHandler
    implements SlugChecker, EmailChecker {
  @override
  late final Logger logger = ref.read(loggerProvider);

  @override
  LogFeature get feature => LogFeature.auth;

  @override
  RegisterState build() => RegisterState.initial();

  // ─── Helpers ───────────────────────────────────────────────────────────────
  bool? isAvailable(AvailabilityField field) =>
      state.availability[field]?.available;
  String? getError(AvailabilityField field) => state.availability[field]?.error;
  bool isChecking(AvailabilityField field) =>
      state.availability[field]?.isChecking ?? false;

  // ─── Setters ───────────────────────────────────────────────────────────────
  void setName(String v) {
    state = state.copyWith(
      formData: state.formData.copyWithField(AuthFields.name, v),
    );
  }

  @override
  void setSlug(String v) {
    final availability =
        Map<
          AvailabilityField,
          ({bool? available, String? error, bool isChecking})
        >.from(state.availability);
    availability[AvailabilityField.slug] = (
      available: null,
      error: null,
      isChecking: false,
    );
    state = state.copyWith(
      formData: state.formData.copyWithField(AuthFields.slug, v),
      availability: availability,
    );
  }

  @override
  void setEmail(String v) {
    final availability =
        Map<
          AvailabilityField,
          ({bool? available, String? error, bool isChecking})
        >.from(state.availability);
    availability[AvailabilityField.email] = (
      available: null,
      error: null,
      isChecking: false,
    );
    state = state.copyWith(
      formData: state.formData.copyWithField(AuthFields.email, v),
      availability: availability,
    );
  }

  void setPassword(String v) {
    state = state.copyWith(
      formData: state.formData.copyWithField(AuthFields.password, v),
    );
  }

  void setConfirmPassword(String v) {
    state = state.copyWith(
      formData: state.formData.copyWithField(AuthFields.confirmPassword, v),
    );
  }

  // ─── Unique Validation ─────────────────────────────────────────────────────
  Future<bool> _validateUnique(AvailabilityField field, String value) async {
    final loadingAvailability =
        Map<
          AvailabilityField,
          ({bool? available, String? error, bool isChecking})
        >.from(state.availability);
    loadingAvailability[field] = (
      available: null,
      error: null,
      isChecking: true,
    );
    state = state.copyWith(availability: loadingAvailability);

    try {
      final repository = ref.read(authRepositoryProvider);
      final availabilityResult = await repository.checkAvailability(
        field: field,
        value: value,
      );

      if (!ref.mounted) return false;

      final availability =
          Map<
            AvailabilityField,
            ({bool? available, String? error, bool isChecking})
          >.from(state.availability);
      availability[field] = (
        available: availabilityResult.available,
        error: null,
        isChecking: false,
      );
      state = state.copyWith(availability: availability);
      logControllerSuccess(action: AuthAction.register);
      return availabilityResult.available;
    } catch (e) {
      if (!ref.mounted) return false;

      final message = e is AppFailure ? e.message : 'Erro inesperado';
      final availability =
          Map<
            AvailabilityField,
            ({bool? available, String? error, bool isChecking})
          >.from(state.availability);
      availability[field] = (
        available: false,
        error: message,
        isChecking: false,
      );
      state = state.copyWith(availability: availability);
      logControllerError(
        action: AuthAction.register,
        failure: e is AppFailure ? e : InternalFailure(message),
      );
      return false;
    }
  }

  // ─── Slug ──────────────────────────────────────────────────────────────────
  @override
  Future<bool> checkSlugAvailability(String slug) =>
      _validateUnique(AvailabilityField.slug, slug);

  @override
  bool? isSlugAvailable() => isAvailable(AvailabilityField.slug);

  @override
  bool isSlugChecking() => isChecking(AvailabilityField.slug);

  // ─── Email ─────────────────────────────────────────────────────────────────
  @override
  Future<bool> checkEmailAvailability(String email) =>
      _validateUnique(AvailabilityField.email, email);

  @override
  bool? isEmailAvailable() => isAvailable(AvailabilityField.email);

  @override
  bool isEmailChecking() => isChecking(AvailabilityField.email);

  // ─── Submit ────────────────────────────────────────────────────────────────
  Future<void> submit() async {
    state = state.copyWith(status: RegisterStatus.loading);

    final authState = ref.read(authStateProvider.notifier);
    final prefs = ref.read(userPreferencesStateProvider.notifier);

    try {
      final repository = ref.read(authRepositoryProvider);
      final authResult = await repository.register(
        registerFormData: state.formData,
      );

      if (!ref.mounted) return;

      logControllerSuccess(action: AuthAction.register);
      await authState.initSession(authResult);
      prefs.setNeedsOnboarding(true);
      state = state.copyWith(status: RegisterStatus.success);
    } catch (e) {
      if (!ref.mounted) return;

      final message = e is AppFailure ? e.message : 'Erro inesperado';
      logControllerError(
        action: AuthAction.register,
        failure: e is AppFailure ? e : InternalFailure(message),
      );
      state = state.copyWith(
        status: RegisterStatus.error,
        errorMessage: message,
      );
    }
  }
}
