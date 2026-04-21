import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:ibiapabaapp/core/entities/entity_type.dart';
import 'package:ibiapabaapp/core/preferences/user_preferences_state_provider.dart';
import 'package:ibiapabaapp/features/categories/domain/entities/category_entity.dart';
import 'package:ibiapabaapp/features/categories/domain/entities/parent_category.dart';
import 'package:ibiapabaapp/features/categories/presentation/providers/categories_providers.dart';
import 'package:ibiapabaapp/features/onboarding/presentation/controllers/profile_interests_controller.dart';
import 'package:ibiapabaapp/features/onboarding/presentation/dialogs/skip_interests_dialog.dart';
import 'package:ibiapabaapp/features/onboarding/presentation/widgets/interests_accordion.dart';
import 'package:ibiapabaapp/features/profiles/domain/entities/profile_interests_response.dart';
import 'package:ibiapabaapp/shared/ui/fragments/effects/default_shimmer_effect.dart';
import 'package:ibiapabaapp/shared/ui/fragments/toast/show_app_toast.dart';
import 'package:skeletonizer/skeletonizer.dart';

final _mockParentCategories = [
  ParentCategory(
    id: 'mock-1',
    name: 'Carregando categoria',
    entities: [EntityType.city],
  ),
  ParentCategory(
    id: 'mock-2',
    name: 'Carregando categoria',
    entities: [EntityType.city],
  ),
  ParentCategory(
    id: 'mock-3',
    name: 'Carregando categoria',
    entities: [EntityType.city],
  ),
];

class UserEventsInterestsScreen extends ConsumerStatefulWidget {
  const UserEventsInterestsScreen({super.key});

  @override
  ConsumerState<UserEventsInterestsScreen> createState() =>
      _UserEventsInterestsScreenState();
}

class _UserEventsInterestsScreenState
    extends ConsumerState<UserEventsInterestsScreen> {
  Set<String> _selected = {};
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _selected = ref
        .read(profileInterestsControllerProvider)
        .interestsData
        .interestsIdsSet
        .toSet();
  }

  void _handleChanged(Set<String> selected) {
    setState(() => _selected = selected);
  }

  void _handleSkip() async {
    final controller = ref.read(profileInterestsControllerProvider.notifier);
    final controllerState = ref.read(profileInterestsControllerProvider);

    if (controllerState.interestsData.businesses.isNotEmpty) {
      setState(() => _isLoading = true);
      try {
        await controller.saveInterests(
          selected: [],
          entity: CategoryEntity.event,
        );

        final result = await controller.submitInterests();
        if (mounted) {
          showResultToast(result ?? ProfileInterestsResponse(count: 0));
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
                showResultToast(result ?? ProfileInterestsResponse(count: 0));
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

  void showResultToast(ProfileInterestsResponse result) {
    if (result.count > 0) {
      showAppToast(
        icon: const Icon(FIcons.check),
        context: context,
        title: const Text('Interesses enviados'),
        description: Text('Seus interesses foram salvos com sucesso!'),
      );
    } else {
      showAppToast(
        icon: const Icon(FIcons.circleX),
        context: context,
        title: const Text('Interesses limpos'),
        description: const Text('Você não verá recomendações personalizadas'),
      );
    }
  }

  void _handleComplete() async {
    setState(() => _isLoading = true);
    try {
      final controller = ref.read(profileInterestsControllerProvider.notifier);

      await controller.saveInterests(
        selected: _selected.toList(),
        entity: CategoryEntity.event,
      );

      final result = await controller.submitInterests();

      if (!mounted) return;

      final controllerState = ref.read(profileInterestsControllerProvider);

      if (controllerState.status == ProfileInterestsStatus.error) {
        showAppToast(
          context: context,
          title: const Text('Erro ao enviar interesses'),
          description: Text(
            controllerState.errorMessage ?? 'Ocorreu um erro inesperado',
          ),
        );
        return;
      }
      ref
          .watch(userPreferencesStateProvider.notifier)
          .setNeedsOnboarding(false);

      showResultToast(result ?? ProfileInterestsResponse(count: 0));

      if (mounted) context.go('/app/home');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(profileInterestsControllerProvider);

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
                  child: Text('Pular'),
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
                      : Text('Finalizar'),
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
