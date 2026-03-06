import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:ibiapabaapp/features/cities/domain/entities/city.dart';
import 'package:ibiapabaapp/features/cities/presentation/providers/cities_providers.dart';
import 'package:ibiapabaapp/features/cities/presentation/widgets/city_card.dart';
import 'package:ibiapabaapp/shared/ui/fragments/effects/default_shimmer_effect.dart';
import 'package:ibiapabaapp/shared/ui/layout/section_header.dart';
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
      spacing: 16,
      children: [
        SectionHeader(
          title: 'Explore as cidades da Ibiapaba',
          onSeeAllTap: () => context.push('/app/cities'),
        ),
        citiesAsync.when(
          skipLoadingOnRefresh: false,
          loading: () => _Section(cities: _mockCities, isLoading: true),

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

          data: (cities) => _Section(cities: cities, isLoading: false),
        ),
      ],
    );
  }
}

class _Section extends StatelessWidget {
  final bool isLoading;
  final List<City> cities;

  const _Section({required this.cities, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
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
