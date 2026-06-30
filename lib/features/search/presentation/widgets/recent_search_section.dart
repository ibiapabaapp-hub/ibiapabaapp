import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:ibivibe/core/session/app_session_notifier_provider.dart';
import 'package:ibivibe/features/search/search_viewmodel.dart';
import 'package:ibivibe/features/search/presentation/widgets/recent_search_item.dart';

class RecentSearchSection extends ConsumerWidget {
  final ValueChanged<String> onSuggestionTap;
  const RecentSearchSection({super.key, required this.onSuggestionTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(appSessionProvider);
    final recentSearches = session.recentSearches;

    if (recentSearches.isEmpty) {
      return Text(
        "Nenhuma pesquisa recente",
        style: context.theme.typography.sm.copyWith(
          color: context.theme.colors.mutedForeground,
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Pesquisas recentes',
              style: context.theme.typography.sm.copyWith(
                color: context.theme.colors.mutedForeground,
              ),
            ),
            FButton(
              style: FButtonStyle.ghost(),
              onPress: () =>
                  ref.read(searchViewModelProvider.notifier).clearRecentSearches(),
              child: Text('Limpar todas', style: context.theme.typography.xs),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Column(
          spacing: 8,
          children: recentSearches
              .map(
                (q) => RecentSearchItem(
                  query: q,
                  onTap: () => onSuggestionTap(q),
                  onRemove: () => ref
                      .read(searchViewModelProvider.notifier)
                      .removeRecentSearch(q),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
