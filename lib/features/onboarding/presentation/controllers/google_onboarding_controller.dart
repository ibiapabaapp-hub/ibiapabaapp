import 'package:ibivibe/core/errors/failures/failures.dart';
import 'package:ibivibe/core/logger/handlers/controller_log_handler.dart';
import 'package:ibivibe/core/logger/log_tags.dart';
import 'package:ibivibe/core/logger/logger.dart';
import 'package:ibivibe/shared/models/account_type.dart';
import 'package:ibivibe/shared/models/gender.dart';
import 'package:ibivibe/features/auth/models/check_availability.dart';
import 'package:ibivibe/features/auth/auth_logtags.dart';
import 'package:ibivibe/features/auth/presentation/providers/auth_providers.dart';
import 'package:ibivibe/features/auth/presentation/providers/google_oauth_state_provider.dart';
import 'package:ibivibe/features/onboarding/presentation/states/google_onboarding_state.dart';
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

    try {
      final repository = ref.read(authRepositoryProvider);
      final availabilityResult = await repository.checkAvailability(
        field: AvailabilityField.slug,
        value: v,
      );

      if (!ref.mounted) return false;

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
    } catch (e) {
      if (!ref.mounted) return false;

      final message = e is AppFailure ? e.message : 'Erro inesperado';
      final availability =
          Map<
            AvailabilityField,
            ({bool? available, String? error, bool isChecking})
          >.from(state.availability);
      availability[AvailabilityField.slug] = (
        available: false,
        error: message,
        isChecking: false,
      );
      state = state.copyWith(availability: availability);
      logControllerError(
        action: AuthAction.completeGoogleRegistration,
        failure: e is AppFailure ? e : InternalFailure(message),
      );
      return false;
    }
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
