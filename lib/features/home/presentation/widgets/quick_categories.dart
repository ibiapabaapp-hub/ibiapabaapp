import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:ibiapabaapp/shared/providers/accounts_state_provider.dart';
import 'package:ibiapabaapp/shared/ui/layout/horizontal_infinite_carousel.dart';
import 'package:ibiapabaapp/shared/utils/show_todo_toast.dart';

const List<String> _defaultCategories = [
  'Restaurantes',
  'Hotéis e Pousadas',
  'Postos de Gasolina',
  'Banhos',
  'Comércio',
  'Aventura',
];

class QuickCategoriesList extends ConsumerWidget {
  const QuickCategoriesList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;

    final interests = ref.watch(accountsStateProvider).activeAccount?.interests;
    final businessesInterests = interests?.businesses
        .map((b) => b.name)
        .toList();
    final eventsInterests = interests?.events.map((b) => b.name).toList();

    final hasNoInterests =
        businessesInterests == null ||
        businessesInterests.isEmpty && eventsInterests == null ||
        eventsInterests!.isEmpty;

    final categoriesToShow = hasNoInterests
        ? _defaultCategories
        : businessesInterests;

    return Column(
      crossAxisAlignment: .start,
      spacing: 8,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Categorias',
            style: theme.typography.base.copyWith(fontWeight: .w600),
          ),
        ),
        HorizontalInfiniteCarousel(
          showProgressBar: false,
          isLoading: false,
          items: categoriesToShow,
          listHeight: 40,
          separator: Container(width: 6),
          itemBuilder: (context, category) => FButton(
            onPress: () => showTodoToast(context, 'Categoria "$category"'),
            style: FButtonStyle.secondary(),
            child: Text(category, style: const TextStyle(fontSize: 14)),
          ),
        ),
      ],
    );
  }
}
