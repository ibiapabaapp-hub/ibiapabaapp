import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:ibivibe/core/entities/entity_type.dart';
import 'package:ibivibe/core/preferences/user_preferences_state_provider.dart';
import 'package:ibivibe/features/accounts/models/account_interests_response.dart';
import 'package:ibivibe/features/accounts/transform_account_interests.dart';
import 'package:ibivibe/shared/models/category_entity.dart';
import 'package:ibivibe/shared/models/parent_category.dart';
import 'package:ibivibe/features/categories/presentation/providers/categories_providers.dart';
import 'package:ibivibe/features/accounts/presentation/controllers/account_interests_controller.dart';
import 'package:ibivibe/features/onboarding/presentation/dialogs/skip_interests_dialog.dart';
import 'package:ibivibe/features/onboarding/presentation/widgets/interests_accordion.dart';
import 'package:ibivibe/shared/ui/fragments/effects/default_shimmer_effect.dart';
import 'package:ibivibe/shared/ui/fragments/toast/show_app_toast.dart';
import 'package:skeletonizer/skeletonizer.dart';

final _mockParentCategories = [
  const ParentCategory(
    id: 'mock-1',
    name: 'Carregando categoria',
    entities: [EntityType.city],
  ),
  const ParentCategory(
    id: 'mock-2',
    name: 'Carregando categoria',
    entities: [EntityType.city],
  ),
  const ParentCategory(
    id: 'mock-3',
    name: 'Carregando categoria',
    entities: [EntityType.city],
  ),
];

class AccountEventsInterestsScreen extends ConsumerStatefulWidget {
  const AccountEventsInterestsScreen({super.key});

  @override
  ConsumerState<AccountEventsInterestsScreen> createState() =>
      _AccountEventsInterestsScreenState();
}

class _AccountEventsInterestsScreenState
    extends ConsumerState<AccountEventsInterestsScreen> {
  Set<String> _selected = {};
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final interests = ref
        .read(accountInterestsControllerProvider)
        .interestsData;
    _selected = getInterestsIdsSet(interests);
  }

  void _handleChanged(Set<String> selected) {
    setState(() => _selected = selected);
  }

  void _handleSkip() async {
    final controller = ref.read(accountInterestsControllerProvider.notifier);
    final controllerState = ref.read(accountInterestsControllerProvider);

    if (controllerState.interestsData.businesses.isNotEmpty) {
      setState(() => _isLoading = true);
      try {
        await controller.saveInterests(
          selected: [],
          entity: CategoryEntity.event,
        );

        final result = await controller.submitInterests();
        if (mounted) {
          showResultToast(result ?? AccountInterestsResponse(count: 0));
        }
        if (mounted) context.go('/app/home');
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
    } else {
      // Se não selecionou NADA em nenhum dos passos
      if (mounted) {
        showSkipInterestsDialog(
          context: context,
          onConfirm: () async {
            setState(() => _isLoading = true);
            try {
              await controller.saveInterests(
                selected: [],
                entity: CategoryEntity.event,
              );
              final result = await controller.submitInterests();
              if (mounted) {
                showResultToast(result ?? AccountInterestsResponse(count: 0));
              }
              if (mounted) context.go('/app/home');
            } finally {
              if (mounted) setState(() => _isLoading = false);
            }
          },
        );
      }
    }
  }

  void showResultToast(AccountInterestsResponse result) {
    if (result.count > 0) {
      showAppToast(
        icon: const Icon(FIcons.check),
        context: context,
        title: 'Interesses enviados',
        description: 'Seus interesses foram salvos com sucesso!',
      );
    } else {
      showAppToast(
        icon: const Icon(FIcons.circleX),
        context: context,
        title: 'Interesses limpos',
        description: 'Você não verá recomendações personalizadas',
      );
    }
  }

  void _handleComplete() async {
    setState(() => _isLoading = true);
    try {
      final controller = ref.read(accountInterestsControllerProvider.notifier);

      await controller.saveInterests(
        selected: _selected.toList(),
        entity: CategoryEntity.event,
      );

      final result = await controller.submitInterests();

      if (!mounted) return;

      final controllerState = ref.read(accountInterestsControllerProvider);

      if (controllerState.status == AccountInterestsStatus.error) {
        showAppToast(
          context: context,
          title: 'Erro ao enviar interesses',
          description:
              controllerState.errorMessage ?? 'Ocorreu um erro inesperado',
        );
        return;
      }
      ref
          .watch(userPreferencesStateProvider.notifier)
          .setNeedsOnboarding(false);

      showResultToast(result ?? AccountInterestsResponse(count: 0));

      if (mounted) context.go('/app/home');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(accountInterestsControllerProvider);

    final categoriesAsync = ref.watch(parentCategoriesProvider(entity: .event));

    return SafeArea(
      child: FScaffold(
        header: FHeader.nested(
          prefixes: [
            FButton.icon(
              style: FButtonStyle.ghost(),
              onPress: context.pop,
              child: const Icon(FIcons.arrowLeft),
            ),
          ],
        ),
        footer: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisSize: .max,
            mainAxisAlignment: .spaceBetween,
            spacing: 8,
            children: [
              Expanded(
                child: FButton(
                  style: FButtonStyle.outline(),
                  onPress: _handleSkip,
                  child: const Text('Pular'),
                ),
              ),
              Expanded(
                child: FButton(
                  onPress: _selected.isNotEmpty && !_isLoading
                      ? _handleComplete
                      : null,
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Finalizar'),
                ),
              ),
            ],
          ),
        ),
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.all(0),
              sliver: SliverList.list(
                children: [
                  Text(
                    'Tipos de eventos',
                    style: context.theme.typography.xl2.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Selecione as categorias para personalizarmos sua experiência',
                    style: context.theme.typography.base.copyWith(
                      color: context.theme.colors.mutedForeground,
                    ),
                  ),
                  const SizedBox(height: 24),
                  categoriesAsync.when(
                    skipLoadingOnRefresh: false,
                    loading: () => Skeletonizer(
                      effect: customShimmerEffect(context),
                      child: InterestsAccordion(
                        categories: _mockParentCategories,
                        initialSelected: _selected,
                        onChanged: _handleChanged,
                        categoriesEntity: CategoryEntity.event,
                      ),
                    ),
                    error: (error, stack) => Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 16,
                        children: [
                          Icon(
                            Icons.error_outline,
                            color: context.theme.colors.mutedForeground,
                            size: 64,
                          ),
                          Text(
                            'Erro ao carregar categorias',
                            style: context.theme.typography.base,
                          ),
                        ],
                      ),
                    ),
                    data: (categories) => InterestsAccordion(
                      categories: categories,
                      initialSelected: _selected,
                      onChanged: _handleChanged,
                      categoriesEntity: CategoryEntity.event,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
