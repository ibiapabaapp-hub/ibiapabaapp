import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:ibiapabaapp/features/cities/domain/entities/city.dart';
import 'package:ibiapabaapp/features/cities/presentation/providers/cities_providers.dart';
import 'package:ibiapabaapp/features/cities/presentation/widgets/city_card.dart';
import 'package:ibiapabaapp/shared/ui/fragments/effects/default_shimmer_effect.dart';
import 'package:ibiapabaapp/shared/ui/layout/section_header.dart';
import 'package:ibiapabaapp/shared/ui/layout/wrappers/main_wrapper.dart';
import 'package:skeletonizer/skeletonizer.dart';

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

class CitiesOverviewScreen extends ConsumerWidget {
  const CitiesOverviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final citiesAsync = ref.watch(citiesProvider);

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
            
            loading: () => _Content(cities: _mockCities, isLoading: true),

            error: (error, stack) => Center(
              child: Expanded(
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

            data: (cities) => _Content(cities: cities, isLoading: false),
          ),
        ),
      ],
    );
  }
}

class _Content extends StatelessWidget {
  final List<City> cities;
  final bool isLoading;

  const _Content({required this.cities, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return MainWrapper(
      hasTopPadding: false,
      children: [
        Row(
          children: [
            FittedBox(
              alignment: Alignment.centerLeft,
              child: FButton(
                style: FButtonStyle.secondary(),
                onPress: () {},
                child: Row(
                  spacing: 4,
                  children: const [
                    Icon(Icons.keyboard_arrow_down_rounded),
                    Text('Categoria'),
                  ],
                ),
              ),
            ),
          ],
        ),
    
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
        header,
        Skeletonizer(
          effect: customShimmerEffect(context),
          enabled: isLoading,
          child: SizedBox(
            height: 270,
            child: ListView.separated(
              cacheExtent: 500,
              addRepaintBoundaries: true,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: cities.length,
              separatorBuilder: (_, _) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                return SizedBox(
                  width: 250,
                  child: CityCard(city: cities[index]),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
