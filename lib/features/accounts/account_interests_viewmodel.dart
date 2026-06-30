import 'package:ibivibe/core/errors/failures/failures.dart';
import 'package:ibivibe/core/logger/handlers/controller_log_handler.dart';
import 'package:ibivibe/core/logger/log_tags.dart';
import 'package:ibivibe/core/logger/logger.dart';
import 'package:ibivibe/features/accounts/models/account_interests.dart';
import 'package:ibivibe/features/accounts/models/account_interests_response.dart';
import 'package:ibivibe/features/accounts/accounts_providers.dart';
import 'package:ibivibe/shared/providers/accounts_viewmodel.dart';
import 'package:ibivibe/shared/models/category_entity.dart';
import 'package:ibivibe/features/categories/categories_providers.dart';
import 'package:ibivibe/features/onboarding/onboarding_logtags.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'account_interests_viewmodel.g.dart';

final _emptyInterests = AccountInterests.empty();

@Riverpod(keepAlive: true)
class AccountInterestsViewModel extends _$AccountInterestsViewModel
    with ControllerLogHandler {
  @override
  late final Logger logger = ref.read(loggerProvider);

  @override
  LogFeature get feature => LogFeature.onboarding;

  @override
  AccountInterestsState build() {
    ref.keepAlive();

    final interests =
        ref.read(accountsViewModelProvider).activeAccount?.interests ??
        _emptyInterests;

    return AccountInterestsState(
      status: AccountInterestsStatus.initial,
      interestsData: interests,
    );
  }

  Future<void> saveInterests({
    required List<String> selected,
    required CategoryEntity entity,
  }) async {
    final account = ref.read(accountsViewModelProvider).activeAccount;
    final sessionInterests = account?.interests ?? _emptyInterests;
    final stateInterests = state.interestsData;

    final baseInterests = AccountInterests(
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
      status: AccountInterestsStatus.initial,
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

  AccountInterests _mergeInterests({
    required AccountInterests base,
    required CategoryEntity entity,
    required List<Interest> selectedInterests,
  }) {
    return switch (entity) {
      CategoryEntity.business => AccountInterests(
        businesses: selectedInterests,
        events: base.events,
      ),
      CategoryEntity.event => AccountInterests(
        businesses: base.businesses,
        events: selectedInterests,
      ),
      _ => base,
    };
  }

  Future<AccountInterestsResponse?> submitInterests() async {
    final account = ref.read(accountsViewModelProvider).activeAccount;

    if (account == null) {
      logControllerError(
        action: OnboardingAction.updateInterests,
        failure: const InternalFailure(
          'Falha no envio: Conta não encontrada na sessão',
        ),
      );
      return null;
    }

    state = state.copyWith(
      status: AccountInterestsStatus.responding,
      clearError: true,
    );

    try {
      final repository = ref.read(accountsRepositoryProvider);
      final result = await repository.updateAccountInterests(
        accountId: account.id,
        interests: state.interestsData,
      );

      if (!ref.mounted) {
        logControllerError(
          action: OnboardingAction.updateInterests,
          failure: const InternalFailure(
            'Envio completado mas controlador foi desmontado.',
          ),
        );
        return AccountInterestsResponse(count: 0);
      }

      logControllerSuccess(action: OnboardingAction.updateInterests);
      state = state.copyWith(
        status: AccountInterestsStatus.completed,
        clearError: true,
      );
      return result;
    } catch (e) {
      final failure = e is AppFailure ? e : InternalFailure('Erro inesperado durante o envio: $e');
      logControllerError(
        action: OnboardingAction.updateInterests,
        failure: failure,
      );
      state = state.copyWith(
        status: AccountInterestsStatus.error,
        errorMessage: failure.message,
      );
      return null;
    }
  }
}

enum AccountInterestsStatus { initial, responding, completed, error }

class AccountInterestsState {
  final AccountInterestsStatus status;
  final AccountInterests interestsData;
  final String? errorMessage;

  AccountInterestsState({
    required this.status,
    required this.interestsData,
    this.errorMessage,
  });

  factory AccountInterestsState.initial() => AccountInterestsState(
    status: AccountInterestsStatus.initial,
    interestsData: _emptyInterests,
  );

  AccountInterestsState copyWith({
    AccountInterestsStatus? status,
    AccountInterests? interestsData,
    String? errorMessage,
    bool clearError = false,
  }) {
    return AccountInterestsState(
      status: status ?? this.status,
      interestsData: interestsData ?? this.interestsData,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}
