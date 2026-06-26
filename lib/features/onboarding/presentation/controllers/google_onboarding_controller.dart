import 'package:ibiapabaapp/core/logger/handlers/controller_log_handler.dart';
import 'package:ibiapabaapp/core/logger/log_tags.dart';
import 'package:ibiapabaapp/core/logger/logger.dart';
import 'package:ibiapabaapp/shared/models/account_type.dart';
import 'package:ibiapabaapp/shared/models/gender.dart';
import 'package:ibiapabaapp/features/auth/domain/entities/check_availability.dart';
import 'package:ibiapabaapp/features/auth/domain/tags/auth_logtags.dart';
import 'package:ibiapabaapp/features/auth/domain/usecases/check_unique_availability.dart';
import 'package:ibiapabaapp/features/auth/presentation/providers/auth_providers.dart';
import 'package:ibiapabaapp/features/auth/presentation/providers/google_oauth_state_provider.dart';
import 'package:ibiapabaapp/features/onboarding/presentation/states/google_onboarding_state.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'google_onboarding_controller.g.dart';

@Riverpod(keepAlive: true)
class GoogleOnboardingController extends _$GoogleOnboardingController
    with ControllerLogHandler {
  @override
  late final Logger logger = ref.read(loggerProvider);

  @override
  LogFeature get feature => LogFeature.onboarding;

  @override
  GoogleOnboardingState build() => GoogleOnboardingState.initial();

  bool? isSlugAvailable() =>
      state.availability[AvailabilityField.slug]?.available;
  String? getSlugError() => state.availability[AvailabilityField.slug]?.error;
  bool isSlugChecking() =>
      state.availability[AvailabilityField.slug]?.isChecking ?? false;

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
    state = state.copyWith(slug: v, availability: availability);
  }

  void setGender(Gender? v) {
    state = state.copyWith(gender: v);
  }

  void setAccountType(AccountType v) {
    state = state.copyWith(accountType: v);
  }

  Future<bool> checkSlug(String v) async {
    final checkAvailability = ref.read(checkUniqueAvailabilityProvider);

    final loadingAvailability =
        Map<
          AvailabilityField,
          ({bool? available, String? error, bool isChecking})
        >.from(state.availability);
    loadingAvailability[AvailabilityField.slug] = (
      available: null,
      error: null,
      isChecking: true,
    );
    state = state.copyWith(availability: loadingAvailability);

    final result = await checkAvailability(
      CheckUniqueAvailabilityParams(field: AvailabilityField.slug, value: v),
    );

    if (!ref.mounted) return false;

    return result.fold(
      (failure) {
        final availability =
            Map<
              AvailabilityField,
              ({bool? available, String? error, bool isChecking})
            >.from(state.availability);
        availability[AvailabilityField.slug] = (
          available: false,
          error: failure.message,
          isChecking: false,
        );
        state = state.copyWith(availability: availability);
        logControllerError(
          action: AuthAction.completeGoogleRegistration,
          failure: failure,
        );
        return false;
      },
      (availabilityResult) {
        final availability =
            Map<
              AvailabilityField,
              ({bool? available, String? error, bool isChecking})
            >.from(state.availability);
        availability[AvailabilityField.slug] = (
          available: availabilityResult.available,
          error: null,
          isChecking: false,
        );
        state = state.copyWith(availability: availability);
        logControllerSuccess(action: AuthAction.completeGoogleRegistration);
        return availabilityResult.available;
      },
    );
  }

  Future<void> submit() async {
    if (state.slug == null ||
        state.gender == null ||
        state.accountType == null) {
      state = state.copyWith(
        status: GoogleOnboardingStatus.error,
        errorMessage: 'Por favor, preencha todos os campos',
      );
      return;
    }

    if (!isSlugAvailable()!) {
      state = state.copyWith(
        status: GoogleOnboardingStatus.error,
        errorMessage: 'Nome de usuário não disponível',
      );
      return;
    }

    state = state.copyWith(status: GoogleOnboardingStatus.loading);

    await ref
        .read(googleOAuthStateProvider.notifier)
        .completeRegistration(
          slug: state.slug!,
          type: state.accountType!,
          gender: state.gender,
        );

    if (!ref.mounted) return;

    final failure = ref.read(googleOAuthStateProvider).failure;
    if (failure != null) {
      logControllerError(
        action: AuthAction.completeGoogleRegistration,
        failure: failure,
      );
      state = state.copyWith(
        status: GoogleOnboardingStatus.error,
        errorMessage: failure.message,
      );
    } else {
      logControllerSuccess(action: AuthAction.completeGoogleRegistration);
      state = state.copyWith(status: GoogleOnboardingStatus.success);
    }
  }

  void reset() {
    state = GoogleOnboardingState.initial();
  }
}
