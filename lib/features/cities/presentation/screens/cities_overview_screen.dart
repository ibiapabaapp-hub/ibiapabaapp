import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:ibiapabaapp/features/cities/domain/entities/city.dart';
import 'package:ibiapabaapp/features/cities/presentation/widgets/city_card.dart';
import 'package:ibiapabaapp/shared/ui/fragments/effects/default_shimmer_effect.dart';
import 'package:ibiapabaapp/shared/ui/layout/section_header.dart';
import 'package:ibiapabaapp/shared/ui/layout/wrappers/main_wrapper.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CitiesOverviewScreen extends StatefulWidget {
  const CitiesOverviewScreen({super.key});

  @override
  State<CitiesOverviewScreen> createState() => _CitiesOverviewScreenState();
}

class _CitiesOverviewScreenState extends State<CitiesOverviewScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) setState(() => _isLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<City> cities = [
      City(
        id: 'ubajara',
        slug: 'ubajara',
        name: 'Ubajara',
        imageUrl:
            'https://imgs.search.brave.com/N4w28VWC72gH2Zi0HYc7q3-sUFkeDmsxHuZtLw7rakc/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly93d3cu/dmlhamFsaS5jb20u/YnIvd3AtY29udGVu/dC91cGxvYWRzLzIw/MjIvMDQvc2VycmEt/ZGEtaWJpYXBhYmEt/OS5qcGc',
        categories: ['Alto da Serra', 'Turismo', 'Belas paisagens'],
      ),
      City(
        id: 'tiangua',
        slug: 'tiangua',
        name: 'Tianguá',
        imageUrl:
            'https://imgs.search.brave.com/N4w28VWC72gH2Zi0HYc7q3-sUFkeDmsxHuZtLw7rakc/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly93d3cu/dmlhamFsaS5jb20u/YnIvd3AtY29udGVu/dC91cGxvYWRzLzIw/MjIvMDQvc2VycmEt/ZGEtaWJpYXBhYmEt/OS5qcGc',
        categories: ['Alto da Serra', 'Urbana'],
      ),
      City(
        id: 'sao_benedito',
        slug: 'sao-benedito',
        name: 'São Benedito',
        imageUrl:
            'https://imgs.search.brave.com/N4w28VWC72gH2Zi0HYc7q3-sUFkeDmsxHuZtLw7rakc/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly93d3cu/dmlhamFsaS5jb20u/YnIvd3AtY29udGVu/dC91cGxvYWRzLzIw/MjIvMDQvc2VycmEt/ZGEtaWJpYXBhYmEt/OS5qcGc',
        categories: ['Alto da Serra', 'Ecoturismo', 'Floricultura'],
      ),
      City(
        id: 'vicosa',
        slug: 'vicosa-do-ceara',
        name: 'Viçosa do Ceará',
        imageUrl:
            'https://imgs.search.brave.com/N4w28VWC72gH2Zi0HYc7q3-sUFkeDmsxHuZtLw7rakc/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly93d3cu/dmlhamFsaS5jb20u/YnIvd3AtY29udGVu/dC91cGxvYWRzLzIw/MjIvMDQvc2VycmEt/ZGEtaWJpYXBhYmEt/OS5qcGc',
        categories: ['Alto da Serra', 'Turismo Histórico', 'Cachaça'],
      ),
    ];

    return Skeletonizer(
      effect: customShimmerEffect(context),
      enabled: _isLoading,
      child: Column(
        children: [
          FHeader.nested(
            title: Skeleton.keep(
              child: Text('Cidades', style: context.theme.typography.base),
            ),
            prefixes: [
              FButton.icon(
                style: FButtonStyle.ghost(),
                onPress: () => context.pop(),
                child: Icon(Icons.arrow_back_rounded, size: 24),
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
                child: Icon(Icons.search, size: 24),
              ),
            ],
          ),
          MainWrapper(
            hasTopPadding: false,
            children: [
              Row(
                mainAxisAlignment: .start,
                children: [
                  FittedBox(
                    alignment: .centerStart,
                    child: FButton(
                      style: FButtonStyle.secondary(),
                      onPress: () {},
                      child: Row(
                        spacing: 4,
                        children: [
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
                header: SectionHeader(
                  title: 'Alto da Serra',
                  onSeeAllTap: null,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final SectionHeader header;
  final List<City> cities;

  const _Section({required this.cities, required this.header});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      spacing: 8,
      children: [
        header,
        SizedBox(
          height: 270,
          child: ListView.separated(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: cities.length,
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              return SizedBox(
                width: 250,
                child: CityCard(city: cities.elementAt(index)),
              );
            },
          ),
        ),
      ],
    );
  }
}
