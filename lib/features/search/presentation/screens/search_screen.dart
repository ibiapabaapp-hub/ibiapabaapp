import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:ibivibe/core/network/dio_provider.dart';
import 'package:ibivibe/shared/providers/accounts_state_provider.dart';
import 'package:ibivibe/features/home/presentation/widgets/explore_cities_section.dart';
import 'package:ibivibe/features/search/presentation/widgets/search_field_shell.dart';
import 'package:ibivibe/shared/ui/layout/items_grid.dart';
import 'package:ibivibe/shared/ui/layout/wrappers/main_wrapper.dart';

class SearchScreen extends ConsumerWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dioClient = ref.watch(dioProvider);
    final interests = ref.watch(accountsStateProvider).activeAccount?.interests;
    final businessesInterests = interests?.businesses
        .map((b) => b.name)
        .toList();
    final eventsInterests = interests?.events.map((b) => b.name).toList();

    final hasNoInterests =
        businessesInterests == null ||
        businessesInterests.isEmpty && eventsInterests == null ||
        eventsInterests!.isEmpty;

    return SafeArea(
      maintainBottomViewPadding: false,
      child: SingleChildScrollView(
        child: Column(
          spacing: 16,
          children: [
            const _SearchHeader(),
            MainWrapper(
              hasTopPadding: false,
              children: [
                hasNoInterests
                    ? const Text(
                        'Atualize seus interesses para ver recomendações certeiras',
                      )
                    : const SizedBox.shrink(),
                businessesInterests == null || businessesInterests.isEmpty
                    ? Text(
                        'Atualize seus interesses para ver recomendações de empresas',
                        style: context.theme.typography.sm.copyWith(
                          color: context.theme.colors.mutedForeground,
                        ),
                      )
                    : ItemsGrid(
                        title: "Empresas",
                        items: businessesInterests,
                        onItemTap: (_) => dioClient.get('/users'),
                        onSeeAllTap: () => context.push('/app/businesses'),
                      ),
                eventsInterests == null || eventsInterests.isEmpty
                    ? Text(
                        'Atualize seus interesses para ver recomendações de eventos',
                        style: context.theme.typography.sm.copyWith(
                          color: context.theme.colors.mutedForeground,
                        ),
                      )
                    : ItemsGrid(
                        title: "Eventos",
                        items: eventsInterests,
                        onSeeAllTap: () => context.push('/app/events'),
                      ),
              ],
            ),
            const ExploreCitiesSection(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _SearchHeader extends StatelessWidget {
  const _SearchHeader();

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return SearchFieldShell(
      child: FButton(
        prefix: Icon(
          FIcons.search,
          size: 16,
          color: theme.colors.mutedForeground,
        ),
        style: FButtonStyle.outline(),
        onPress: () => context.push('/app/search/expanded'),
        child: Text(
          'O que vamos fazer hoje na Ibiapaba?',
          style: theme.typography.sm.copyWith(
            color: theme.colors.mutedForeground,
          ),
        ),
      ),
    );
  }
}
