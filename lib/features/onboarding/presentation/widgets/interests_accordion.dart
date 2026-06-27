import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:ibiapabaapp/shared/models/category_entity.dart';
import 'package:ibiapabaapp/shared/models/child_category.dart';
import 'package:ibiapabaapp/shared/models/parent_category.dart';
import 'package:ibiapabaapp/features/categories/presentation/providers/categories_providers.dart';
import 'package:ibiapabaapp/shared/ui/fragments/effects/default_shimmer_effect.dart';
import 'package:skeletonizer/skeletonizer.dart';

IconData getCategoryIcon(String name) {
  const icons = {
    'Comércio': FIcons.store,
    'Alimentação e Bebidas': FIcons.utensils,
    'Turismo e Hospitalidade': FIcons.mapPin,
    'Cultura, Lazer e Entretenimento': FIcons.music,
    'Saúde e Bem-estar': FIcons.heart,
    'Serviços Gerais': FIcons.wrench,
    'Educação e Capacitação': FIcons.graduationCap,
    'Serviços Profissionais': FIcons.briefcase,
    'Indústria e Produção': FIcons.factory,
    'Agronegócio e Economia Rural': FIcons.sprout,
    'Financeiro e Imobiliário': FIcons.landmark,
    'Institucional e Terceiro Setor': FIcons.handshake,
    'Eventos Abertos ao Público': FIcons.ferrisWheel,
    'Eventos Comerciais': FIcons.shoppingBasket,
    'Eventos Corporativos': FIcons.micVocal,
  };
  return icons[name] ?? FIcons.tag;
}

class InterestsAccordion extends StatefulWidget {
  const InterestsAccordion({
    super.key,
    required this.categories,
    this.initialSelected = const {},
    required this.onChanged,
    required this.categoriesEntity,
  });

  final CategoryEntity categoriesEntity;
  final List<ParentCategory> categories;
  final Set<String> initialSelected;
  final void Function(Set<String> selected) onChanged;

  @override
  State<InterestsAccordion> createState() => _InterestsAccordionState();
}

class _InterestsAccordionState extends State<InterestsAccordion> {
  late final ValueNotifier<Set<String>> _selected;
  int? _expandedIndex;

  @override
  void initState() {
    super.initState();
    _selected = ValueNotifier(Set<String>.from(widget.initialSelected));
  }

  @override
  void dispose() {
    _selected.dispose();
    super.dispose();
  }

  void _toggle(String catId, String subId) {
    final next = Set<String>.from(_selected.value);
    next.contains(subId) ? next.remove(subId) : next.add(subId);
    _selected.value = next;
    widget.onChanged(_selected.value);
  }

  void _toggleAll(String catId, List<ChildCategory> subcategories) {
    final next = Set<String>.from(_selected.value);
    final allSubIds = subcategories.map((s) => s.id).toSet();

    if (allSubIds.every(next.contains)) {
      for (final id in allSubIds) {
        next.remove(id);
      }
    } else {
      next.addAll(allSubIds);
    }
    _selected.value = next;
    widget.onChanged(_selected.value);
  }

  bool _isAllSelected(String catId, List<ChildCategory> subcategories) {
    if (subcategories.isEmpty) return false;
    return subcategories.every((s) => _selected.value.contains(s.id));
  }

  int _countForCat(String catId, List<ChildCategory>? loadedSubcategories) {
    if (loadedSubcategories == null) return 0;
    final catSubIds = loadedSubcategories.map((s) => s.id).toSet();
    return _selected.value.intersection(catSubIds).length;
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Column(
      children: List.generate(widget.categories.length, (index) {
        final cat = widget.categories[index];
        final isExpanded = _expandedIndex == index;

        return Column(
          children: [
            FTappable(
              onPress: () {
                setState(() {
                  _expandedIndex = isExpanded ? null : index;
                });
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 4,
                ),
                child: Row(
                  children: [
                    Icon(getCategoryIcon(cat.name), size: 18),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        cat.name,
                        style: theme.typography.base.copyWith(
                          fontWeight: isExpanded
                              ? FontWeight.w600
                              : FontWeight.w400,
                        ),
                      ),
                    ),
                    ValueListenableBuilder(
                      valueListenable: _selected,
                      builder: (context, selectedState, _) {
                        if (cat.id.startsWith('mock')) {
                          return const SizedBox.shrink();
                        }

                        return Consumer(
                          builder: (context, ref, _) {
                            final childrenAsync = ref.watch(
                              childCategoriesProvider(
                                parentId: cat.id,
                                entity: widget.categoriesEntity,
                              ),
                            );

                            return childrenAsync.maybeWhen(
                              data: (children) {
                                final count = _countForCat(cat.id, children);
                                if (count == 0) return const SizedBox.shrink();
                                return Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: FBadge(child: Text('$count')),
                                );
                              },
                              orElse: () => const SizedBox.shrink(),
                            );
                          },
                        );
                      },
                    ),
                    AnimatedRotation(
                      duration: const Duration(milliseconds: 200),
                      turns: isExpanded ? 0.5 : 0,
                      child: Icon(
                        FIcons.chevronDown,
                        size: 16,
                        color: context.theme.colors.mutedForeground,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            FCollapsible(
              value: isExpanded ? 1 : 0,
              child: _SubcategoryChipsLoader(
                categoriesEntity: widget.categoriesEntity,
                parentId: cat.id,
                isExpanded: isExpanded,
                parentSelected: _selected,
                onToggle: _toggle,
                onToggleAll: _toggleAll,
                isAllSelected: _isAllSelected,
              ),
            ),
            if (index < widget.categories.length - 1)
              Divider(height: 1, color: theme.colors.border.withAlpha(150)),
          ],
        );
      }),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// _SubcategoryChipsLoader — carrega os filhos e renderiza os chips
// ─────────────────────────────────────────────────────────────────────────────

final _mockSubcategories = List.generate(
  6,
  (i) =>
      ChildCategory(id: 'mock─sub─$i', name: 'Subcategoria $i', entities: []),
);

class _SubcategoryChipsLoader extends ConsumerWidget {
  const _SubcategoryChipsLoader({
    required this.parentId,
    required this.isExpanded,
    required this.categoriesEntity,
    required this.parentSelected,
    required this.onToggle,
    required this.onToggleAll,
    required this.isAllSelected,
  });

  final String parentId;
  final bool isExpanded;
  final CategoryEntity categoriesEntity;
  final ValueNotifier<Set<String>> parentSelected;
  final void Function(String catId, String subId) onToggle;
  final void Function(String catId, List<ChildCategory> subcategories)
  onToggleAll;
  final bool Function(String catId, List<ChildCategory> subcategories)
  isAllSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!isExpanded || parentId.startsWith('mock')) {
      return const SizedBox.shrink();
    }

    final childrenAsync = ref.watch(
      childCategoriesProvider(parentId: parentId, entity: categoriesEntity),
    );

    return childrenAsync.when(
      loading: () => Skeletonizer(
        enabled: true,
        effect: customShimmerEffect(context),
        child: _ChipsContent(
          categoryId: parentId,
          subcategories: _mockSubcategories,
          selected: parentSelected,
          onToggle: onToggle,
          onToggleAll: onToggleAll,
          isAllSelected: isAllSelected,
        ),
      ),
      error: (error, stack) => _ErrorState(
        onRetry: () => ref.refresh(
          childCategoriesProvider(parentId: parentId, entity: categoriesEntity),
        ),
      ),
      data: (children) => _ChipsContent(
        categoryId: parentId,
        subcategories: children,
        selected: parentSelected,
        onToggle: onToggle,
        onToggleAll: onToggleAll,
        isAllSelected: isAllSelected,
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// _ChipsContent — grade de chips + botão "Selecionar / Remover tudo"
// ─────────────────────────────────────────────────────────────────────────────

class _ChipsContent extends StatelessWidget {
  const _ChipsContent({
    required this.categoryId,
    required this.subcategories,
    required this.selected,
    required this.onToggle,
    required this.onToggleAll,
    required this.isAllSelected,
  });

  final String categoryId;
  final List<ChildCategory> subcategories;
  final ValueNotifier<Set<String>> selected;
  final void Function(String catId, String subId) onToggle;
  final void Function(String catId, List<ChildCategory> subcategories)
  onToggleAll;
  final bool Function(String catId, List<ChildCategory> subcategories)
  isAllSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 20),
      child: ValueListenableBuilder(
        valueListenable: selected,
        builder: (context, snap, _) {
          final isFull = isAllSelected(categoryId, subcategories);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: subcategories.map((sub) {
                  final isSubSelected = snap.contains(sub.id);
                  return _SelectableChip(
                    label: sub.name,
                    isSelected: isSubSelected,
                    onTap: () => onToggle(categoryId, sub.id),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              FButton(
                style: FButtonStyle.outline(),
                onPress: () => onToggleAll(categoryId, subcategories),
                prefix: Icon(isFull ? FIcons.x : FIcons.plus),
                child: Text(isFull ? 'Remover tudo' : 'Adicionar tudo'),
              ),
            ],
          );
        },
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// _ErrorState
// ─────────────────────────────────────────────────────────────────────────────

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          Text(
            'Não foi possível carregar as opções.',
            style: context.theme.typography.sm.copyWith(
              color: context.theme.colors.mutedForeground,
            ),
          ),
          const SizedBox(height: 8),
          FButton(
            style: FButtonStyle.ghost(),
            onPress: onRetry,
            child: const Text('Tentar novamente'),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// _SelectableChip
// ─────────────────────────────────────────────────────────────────────────────

class _SelectableChip extends StatelessWidget {
  const _SelectableChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return FTappable(
      onPress: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? theme.colors.primary : theme.colors.background,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? theme.colors.primary : theme.colors.border,
          ),
        ),
        child: Text(
          label,
          style: theme.typography.sm.copyWith(
            color: isSelected
                ? theme.colors.primaryForeground
                : theme.colors.foreground,
            fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
