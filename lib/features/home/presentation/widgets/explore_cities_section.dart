import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:ibiapabaapp/shared/models/city.dart';
import 'package:ibiapabaapp/features/cities/presentation/controllers/cities_controller.dart';
import 'package:ibiapabaapp/features/cities/presentation/widgets/city_card.dart';
import 'package:ibiapabaapp/shared/ui/layout/vertical_items_list.dart';
import 'package:ibiapabaapp/shared/ui/layout/section_header.dart';

final List<City> _mockCities = List.generate(
  5,
  (index) => City(
    id: 'mock-$index',
    slug: 'mock',
    name: 'Carregando cidade',
    coverImgUrl: '',
    categories: ['Categoria', 'Subcategoria'],
  ),
);

class ExploreCitiesSection extends ConsumerStatefulWidget {
  const ExploreCitiesSection({super.key});

  @override
  ConsumerState<ExploreCitiesSection> createState() =>
      _ExploreCitiesSectionState();
}

class _ExploreCitiesSectionState extends ConsumerState<ExploreCitiesSection> {
  @override
  Widget build(BuildContext context) {
    final citiesAsync = ref.watch(citiesProvider);

    return Column(
      mainAxisAlignment: .start,
      crossAxisAlignment: .start,
      spacing: 8,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SectionHeader(
            title: 'Explore as cidades da Ibiapaba',
            onSeeAllTap: () => context.push('/app/cities'),
          ),
        ),
        citiesAsync.when(
          skipLoadingOnRefresh: false,
          loading: () => VerticalItemsList(
            isLoading: true,
            items: _mockCities,
            separator: const SizedBox(height: 24),
            itemBuilder: (_, city) => CityCard(city: city),
          ),

          error: (error, stack) => Center(
            child: Column(
              mainAxisAlignment: .center,
              spacing: 16,
              children: [
                Icon(
                  Icons.error_outline,
                  color: context.theme.colors.mutedForeground,
                  size: 64,
                ),
                Text(
                  'Erro ao carregar cidades',
                  style: context.theme.typography.base,
                ),
              ],
            ),
          ),

          data: (cities) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: VerticalItemsList(
              isLoading: false,
              items: cities,
              separator: const SizedBox(height: 24),
              itemBuilder: (_, city) => CityCard(city: city),
            ),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
