import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:ibivibe/shared/models/city.dart';
import 'package:ibivibe/features/cities/cities_viewmodel.dart';
import 'package:ibivibe/features/cities/city_card.dart';
import 'package:ibivibe/shared/ui/layout/horizontal_infinite_carousel.dart';
import 'package:ibivibe/shared/ui/layout/section_header.dart';

final List<City> _mockCities = List.generate(
  5,
  (index) => City(
    id: 'mock-$index',
    slug: 'mock',
    name: 'Nome da Cidade',
    coverImgUrl: 'loading',
    categories: ['Categoria', 'Subcategoria'],
  ),
);

class CitiesOverviewScreen extends ConsumerStatefulWidget {
  const CitiesOverviewScreen({super.key});

  @override
  ConsumerState<CitiesOverviewScreen> createState() =>
      _CitiesOverviewScreenState();
}

class _CitiesOverviewScreenState extends ConsumerState<CitiesOverviewScreen> {
  @override
  Widget build(BuildContext context) {
    final citiesAsync = ref.watch(citiesViewModelProvider);

    return Column(
      children: [
        FHeader.nested(
          title: Text('Cidades', style: context.theme.typography.base),
          prefixes: [
            FButton.icon(
              style: FButtonStyle.ghost(),
              onPress: () => context.pop(),
              child: const Icon(Icons.arrow_back_rounded, size: 24),
            ),
          ],
          suffixes: [
            FButton.icon(
              style: FButtonStyle.ghost(),
              onPress: () {
                showFToast(
                  context: context,
                  title: Text(
                    'TODO: Implementar redirect para expandedSearch',
                    style: context.theme.typography.sm,
                  ),
                );
              },
              child: const Icon(Icons.search, size: 24),
            ),
          ],
        ),

        Expanded(
          child: citiesAsync.when(
            skipLoadingOnRefresh: false,
            loading: () => _Content(
              cities: _mockCities,
              isLoading: true,
              refreshCities: () => ref.read(citiesViewModelProvider.notifier).refresh(),
            ),

            data: (cities) => _Content(
              cities: cities,
              isLoading: false,
              refreshCities: () => ref.read(citiesViewModelProvider.notifier).refresh(),
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
          ),
        ),
      ],
    );
  }
}

class _Content extends StatelessWidget {
  final List<City> cities;
  final bool isLoading;
  final Future<void> Function() refreshCities;

  const _Content({
    required this.cities,
    required this.isLoading,
    required this.refreshCities,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      children: [
        _Section(
          cities: cities,
          isLoading: isLoading,
          header: const SectionHeader(
            title: 'Alto da Serra',
            onSeeAllTap: null,
          ),
        ),
      ],
    );
  }
}

class _Section extends StatelessWidget {
  final bool isLoading;
  final SectionHeader header;
  final List<City> cities;

  const _Section({
    required this.cities,
    required this.header,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: header,
        ),
        HorizontalInfiniteCarousel(
          isLoading: isLoading,
          items: cities,
          itemWidth: 220,
          listHeight: 210,
          separator: const SizedBox(width: 12),
          itemBuilder: (_, city) => CityCard(city: city),
        ),
      ],
    );
  }
}
