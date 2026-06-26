import 'package:ibiapabaapp/core/logger/handlers/controller_log_handler.dart';
import 'package:ibiapabaapp/core/logger/log_tags.dart';
import 'package:ibiapabaapp/core/logger/logger.dart';
import 'package:ibiapabaapp/core/preferences/user_preferences_state_provider.dart';
import 'package:ibiapabaapp/features/auth/domain/entities/check_availability.dart';
import 'package:ibiapabaapp/features/auth/domain/tags/auth_logtags.dart';
import 'package:ibiapabaapp/features/auth/domain/usecases/check_unique_availability.dart';
import 'package:ibiapabaapp/features/auth/domain/usecases/register_with_email.dart';
import 'package:ibiapabaapp/features/auth/presentation/providers/auth_providers.dart';
import 'package:ibiapabaapp/features/auth/presentation/providers/auth_state_provider.dart';
import 'package:ibiapabaapp/features/auth/presentation/states/register_state.dart';
import 'package:ibiapabaapp/features/auth/validation/auth_validator.dart';
import 'package:ibiapabaapp/shared/ui/forms/fields/email/email_checker.dart';
import 'package:ibiapabaapp/shared/ui/forms/fields/slug/slug_checker.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'register_controller.g.dart';

@riverpod
class RegisterController extends _$RegisterController
    with ControllerLogHandler
    implements SlugChecker, EmailChecker /*, PhoneChecker */ {
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

  // void setBirthDate(DateTime? v) {
  //   state = state.copyWith(
  //     formData: state.formData.copyWithField(AuthFields.birthDate, v),
  //   );
  // }

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

  // @override
  // void setPhone(String v) {
  //   final availability =
  //       Map<
  //         AvailabilityField,
  //         ({bool? available, String? error, bool isChecking})
  //       >.from(state.availability);
  //   availability[AvailabilityField.phoneNumber] = (
  //     available: null,
  //     error: null,
  //     isChecking: false,
  //   );
  //   state = state.copyWith(
  //     formData: state.formData.copyWithField(AuthFields.phoneNumber, v),
  //     availability: availability,
  //   );
  // }

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
    final checkAvailability = ref.read(checkUniqueAvailabilityProvider);

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

    final result = await checkAvailability(
      CheckUniqueAvailabilityParams(field: field, value: value),
    );

    if (!ref.mounted) return false;

    return result.fold(
      (failure) {
        final availability =
            Map<
              AvailabilityField,
              ({bool? available, String? error, bool isChecking})
            >.from(state.availability);
        availability[field] = (
          available: false,
          error: failure.message,
          isChecking: false,
        );
        state = state.copyWith(availability: availability);
        logControllerError(action: AuthAction.register, failure: failure);
        return false;
      },
      (availabilityResult) {
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
      },
    );
  }

  // Future<bool> checkPhone(String v) =>
  //     _validateUnique(AvailabilityField.phoneNumber, v);

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

  // @override
  // Future<bool> checkPhoneAvailability(String phone) =>
  //     _validateUnique(AvailabilityField.phoneNumber, phone);

  // @override
  // bool? isPhoneAvailable() => isAvailable(AvailabilityField.phoneNumber);

  // @override
  // bool isPhoneChecking() => isChecking(AvailabilityField.phoneNumber);

  // ─── Submit ────────────────────────────────────────────────────────────────
  Future<void> submit() async {
    state = state.copyWith(status: RegisterStatus.loading);

    final registerWithEmail = ref.read(registerWithEmailProvider);
    final authState = ref.read(authStateProvider.notifier);
    final prefs = ref.read(userPreferencesStateProvider.notifier);

    final result = await registerWithEmail(
      RegisterWithEmailParams(registerFormData: state.formData),
    );

    if (!ref.mounted) return;

    await result.fold(
      (failure) async {
        logControllerError(action: AuthAction.register, failure: failure);
        state = state.copyWith(
          status: RegisterStatus.error,
          errorMessage: failure.message,
        );
      },
      (authResult) async {
        logControllerSuccess(action: AuthAction.register);
        await authState.initSession(authResult);
        prefs.setNeedsOnboarding(true);
        state = state.copyWith(status: RegisterStatus.success);
      },
    );
  }
}
