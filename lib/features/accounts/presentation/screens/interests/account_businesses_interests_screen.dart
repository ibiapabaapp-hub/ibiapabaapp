import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:ibiapabaapp/core/entities/entity_type.dart';
import 'package:ibiapabaapp/features/accounts/domain/utils/transform_account_interests.dart';
import 'package:ibiapabaapp/shared/models/parent_category.dart';
import 'package:ibiapabaapp/features/categories/presentation/providers/categories_providers.dart';
import 'package:ibiapabaapp/shared/models/category_entity.dart';
import 'package:ibiapabaapp/features/accounts/presentation/controllers/account_interests_controller.dart';
import 'package:ibiapabaapp/features/onboarding/presentation/widgets/interests_accordion.dart';
import 'package:ibiapabaapp/shared/ui/fragments/effects/default_shimmer_effect.dart';
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

class AccountBusinessesInterestsScreen extends ConsumerStatefulWidget {
  const AccountBusinessesInterestsScreen({super.key});

  @override
  ConsumerState<AccountBusinessesInterestsScreen> createState() =>
      _AccountBusinessesInterestsScreenState();
}

class _AccountBusinessesInterestsScreenState
    extends ConsumerState<AccountBusinessesInterestsScreen> {
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
    setState(() => _isLoading = true);
    try {
      await ref
          .read(accountInterestsControllerProvider.notifier)
          .saveInterests(selected: [], entity: CategoryEntity.business);
      if (mounted) context.push('/app/interests/events');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _handleComplete() async {
    setState(() => _isLoading = true);
    try {
      await ref
          .read(accountInterestsControllerProvider.notifier)
          .saveInterests(
            selected: _selected.toList(),
            entity: CategoryEntity.business,
          );

      if (mounted) context.push('/app/interests/events');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final categoriesAsync = ref.watch(
      parentCategoriesProvider(entity: .business),
    );

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
            spacing: 16,
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
                      : const Text('Continuar'),
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
                    'Quais são seus interesses?',
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
                        categoriesEntity: CategoryEntity.business,
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
                      categoriesEntity: CategoryEntity.business,
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
