import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:ibivibe/shared/models/tag_group.dart';
import 'package:ibivibe/shared/models/tag.dart';

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
    required this.tagGroups,
    this.initialSelected = const {},
    required this.onChanged,
  });

  final List<TagGroup> tagGroups;
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

  void _toggle(String tagId) {
    final next = Set<String>.from(_selected.value);
    next.contains(tagId) ? next.remove(tagId) : next.add(tagId);
    _selected.value = next;
    widget.onChanged(_selected.value);
  }

  void _toggleAll(List<Tag> tags) {
    final next = Set<String>.from(_selected.value);
    final allTagIds = tags.map((t) => t.id).toSet();

    if (allTagIds.every(next.contains)) {
      for (final id in allTagIds) {
        next.remove(id);
      }
    } else {
      next.addAll(allTagIds);
    }
    _selected.value = next;
    widget.onChanged(_selected.value);
  }

  bool _isAllSelected(List<Tag> tags) {
    if (tags.isEmpty) return false;
    return tags.every((t) => _selected.value.contains(t.id));
  }

  int _countForGroup(List<Tag> tags) {
    final tagIds = tags.map((t) => t.id).toSet();
    return _selected.value.intersection(tagIds).length;
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Column(
      children: List.generate(widget.tagGroups.length, (index) {
        final group = widget.tagGroups[index];
        final isExpanded = _expandedIndex == index;
        final tags = group.tags;
        final count = _countForGroup(tags);

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
                    Icon(getCategoryIcon(group.name), size: 18),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        group.name,
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
                        if (count == 0) return const SizedBox.shrink();
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: FBadge(child: Text('$count')),
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
              child: _ChipsContent(
                tags: tags,
                selected: _selected,
                onToggle: _toggle,
                onToggleAll: _toggleAll,
                isAllSelected: _isAllSelected,
              ),
            ),
            if (index < widget.tagGroups.length - 1)
              Divider(height: 1, color: theme.colors.border.withAlpha(150)),
          ],
        );
      }),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// _ChipsContent — grade de chips + botão "Selecionar / Remover tudo"
// ─────────────────────────────────────────────────────────────────────────────

class _ChipsContent extends StatelessWidget {
  const _ChipsContent({
    required this.tags,
    required this.selected,
    required this.onToggle,
    required this.onToggleAll,
    required this.isAllSelected,
  });

  final List<Tag> tags;
  final ValueNotifier<Set<String>> selected;
  final void Function(String tagId) onToggle;
  final void Function(List<Tag> tags) onToggleAll;
  final bool Function(List<Tag> tags) isAllSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 20),
      child: ValueListenableBuilder(
        valueListenable: selected,
        builder: (context, snap, _) {
          final isFull = isAllSelected(tags);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: tags.map((tag) {
                  final isTagSelected = snap.contains(tag.id);
                  return _SelectableChip(
                    label: tag.name,
                    isSelected: isTagSelected,
                    onTap: () => onToggle(tag.id),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              FButton(
                style: FButtonStyle.outline(),
                onPress: () => onToggleAll(tags),
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
