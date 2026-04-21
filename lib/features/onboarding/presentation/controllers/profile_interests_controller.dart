import 'package:ibiapabaapp/core/errors/failures/failures.dart';
import 'package:ibiapabaapp/core/logger/handlers/controller_log_handler.dart';
import 'package:ibiapabaapp/core/logger/log_tags.dart';
import 'package:ibiapabaapp/core/logger/logger.dart';
import 'package:ibiapabaapp/features/categories/domain/entities/category_entity.dart';
import 'package:ibiapabaapp/features/categories/presentation/providers/categories_providers.dart';
import 'package:ibiapabaapp/features/onboarding/domain/tags/onboarding_logtags.dart';
import 'package:ibiapabaapp/features/profiles/domain/entities/profile_interests.dart';
import 'package:ibiapabaapp/features/profiles/domain/entities/profile_interests_response.dart';
import 'package:ibiapabaapp/features/profiles/domain/usecases/update_profile_interests.dart';
import 'package:ibiapabaapp/features/profiles/presentation/providers/profile_state_provider.dart';
import 'package:ibiapabaapp/features/profiles/presentation/providers/profiles_providers.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_interests_controller.g.dart';

const _emptyInterests = ProfileInterests.empty();

@Riverpod(keepAlive: true)
class ProfileInterestsController extends _$ProfileInterestsController
    with ControllerLogHandler {
  @override
  late final Logger logger = ref.read(loggerProvider);

  @override
  LogFeature get feature => LogFeature.onboarding;

  @override
  ProfileInterestsState build() {
    ref.keepAlive();

    final interests =
        ref.read(profileStateProvider).activeProfile?.interests ??
        _emptyInterests;

    return ProfileInterestsState(
      status: ProfileInterestsStatus.initial,
      interestsData: interests,
    );
  }

  Future<void> saveInterests({
    required List<String> selected,
    required CategoryEntity entity,
  }) async {
    final profile = ref.read(profileStateProvider).activeProfile;
    final sessionInterests = profile?.interests ?? _emptyInterests;
    final stateInterests = state.interestsData;

    final baseInterests = ProfileInterests(
      businesses: stateInterests.businesses.isNotEmpty
          ? stateInterests.businesses
          : sessionInterests.businesses,
      events: stateInterests.events.isNotEmpty
          ? stateInterests.events
          : sessionInterests.events,
    );

    final selectedInterests = selected.isEmpty
        ? const <Interest>[]
        : await _mapSelectedInterests(selected: selected, entity: entity);

    final updated = _mergeInterests(
      base: baseInterests,
      entity: entity,
      selectedInterests: selectedInterests,
    );

    state = state.copyWith(
      interestsData: updated,
      status: ProfileInterestsStatus.initial,
      clearError: true,
    );
  }

  Future<List<Interest>> _mapSelectedInterests({
    required List<String> selected,
    required CategoryEntity entity,
  }) async {
    final categories = await ref.read(
      parentCategoriesProvider(entity: entity).future,
    );

    final allChildren = categories
        .expand((parent) => parent.children ?? const [])
        .toList(growable: false);

    final byId = {for (final child in allChildren) child.id: child.name};

    return selected
        .map((id) => Interest(id: id, name: byId[id] ?? id))
        .toList(growable: false);
  }

  ProfileInterests _mergeInterests({
    required ProfileInterests base,
    required CategoryEntity entity,
    required List<Interest> selectedInterests,
  }) {
    return switch (entity) {
      CategoryEntity.business => ProfileInterests(
        businesses: selectedInterests,
        events: base.events,
      ),
      CategoryEntity.event => ProfileInterests(
        businesses: base.businesses,
        events: selectedInterests,
      ),
      _ => base,
    };
  }

  Future<ProfileInterestsResponse?> submitInterests() async {
    final profile = ref.read(profileStateProvider).activeProfile;

    if (profile == null) {
      logControllerError(
        action: OnboardingAction.updateInterests,
        failure: InternalFailure(
          'Falha no envio: Perfil não encontrado na sessão',
        ),
      );
      return null;
    }

    state = state.copyWith(
      status: ProfileInterestsStatus.responding,
      clearError: true,
    );

    try {
      final result = await ref
          .read(updateProfileInterestsProvider)
          .call(
            UpdateProfileInterestsParams(
              profileId: profile.id,
              interests: state.interestsData,
            ),
          );

      if (!ref.mounted) {
        logControllerError(
          action: OnboardingAction.updateInterests,
          failure: InternalFailure(
            'Envio completado mas controlador foi desmontado.',
          ),
        );
        return ProfileInterestsResponse(count: 0);
      }

      return result.fold(
        (failure) {
          logger.e('Falha na API: ${failure.message}');
          logControllerError(
            action: OnboardingAction.updateInterests,
            failure: failure,
          );
          state = state.copyWith(
            status: ProfileInterestsStatus.error,
            errorMessage: failure.message,
          );
          return null;
        },
        (success) {
          logControllerSuccess(action: OnboardingAction.updateInterests);
          state = state.copyWith(
            status: ProfileInterestsStatus.completed,
            clearError: true,
          );
          return success;
        },
      );
    } catch (e) {
      logControllerError(
        action: OnboardingAction.updateInterests,
        failure: InternalFailure('Erro inesperado durante o envio: $e'),
      );
      state = state.copyWith(
        status: ProfileInterestsStatus.error,
        errorMessage: 'Ocorreu um erro inesperado ao salvar seus interesses.',
      );
      return null;
    }
  }
}

enum ProfileInterestsStatus { initial, responding, completed, error }

class ProfileInterestsState {
  final ProfileInterestsStatus status;
  final ProfileInterests interestsData;
  final String? errorMessage;

  ProfileInterestsState({
    required this.status,
    required this.interestsData,
    this.errorMessage,
  });

  factory ProfileInterestsState.initial() => ProfileInterestsState(
    status: ProfileInterestsStatus.initial,
    interestsData: _emptyInterests,
  );

  ProfileInterestsState copyWith({
    ProfileInterestsStatus? status,
    ProfileInterests? interestsData,
    String? errorMessage,
    bool clearError = false,
  }) {
    return ProfileInterestsState(
      status: status ?? this.status,
      interestsData: interestsData ?? this.interestsData,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}
