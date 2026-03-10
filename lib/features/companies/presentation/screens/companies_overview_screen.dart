import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:ibiapabaapp/features/companies/domain/entities/company.dart';
import 'package:ibiapabaapp/features/companies/presentation/controllers/companies_controller.dart';
import 'package:ibiapabaapp/features/companies/presentation/widgets/company_card.dart';
import 'package:ibiapabaapp/shared/ui/fragments/effects/default_shimmer_effect.dart';
import 'package:ibiapabaapp/shared/ui/layout/section_header.dart';
import 'package:ibiapabaapp/shared/ui/layout/wrappers/main_wrapper.dart';
import 'package:skeletonizer/skeletonizer.dart';

final List<Company> _mockCompanies = List.generate(
  5,
  (index) => Company(
    id: 'mock-$index',
    slug: 'mock',
    cnpj: 'cnpj',
    name: 'Carregando empresa',
    maxReachLevel: ReachLevel.regional,
    coverImgUrl: '',
    categories: ['Categoria', 'Subcategoria'],
  ),
);

class CompaniesOverviewScreen extends ConsumerStatefulWidget {
  const CompaniesOverviewScreen({super.key});

  @override
  ConsumerState<CompaniesOverviewScreen> createState() =>
      _CompaniesOverviewScreenState();
}

class _CompaniesOverviewScreenState
    extends ConsumerState<CompaniesOverviewScreen> {
  @override
  Widget build(BuildContext context) {
    final companiesAsync = ref.watch(companiesProvider);

    return Column(
      children: [
        FHeader.nested(
          title: Text('Empresas', style: context.theme.typography.base),
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
          child: companiesAsync.when(
            skipLoadingOnRefresh: false,

            loading: () => _Content(companies: _mockCompanies, isLoading: true),

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

            data: (companies) =>
                _Content(companies: companies, isLoading: false),
          ),
        ),
      ],
    );
  }
}

class _Content extends StatelessWidget {
  final List<Company> companies;
  final bool isLoading;

  const _Content({required this.companies, required this.isLoading});

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
          companies: companies,
          isLoading: isLoading,
          header: const SectionHeader(title: 'Novos no app', onSeeAllTap: null),
        ),
      ],
    );
  }
}

class _Section extends StatelessWidget {
  final bool isLoading;
  final SectionHeader header;
  final List<Company> companies;

  const _Section({
    required this.companies,
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
              itemCount: companies.length,
              separatorBuilder: (_, _) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                return SizedBox(
                  width: 250,
                  child: CompanyCard(company: companies[index]),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
