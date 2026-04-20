import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:ibiapabaapp/features/businesses/domain/entities/business.dart';
import 'package:ibiapabaapp/features/businesses/presentation/controllers/businesses_controller.dart';
import 'package:ibiapabaapp/features/businesses/presentation/widgets/business_card.dart';
import 'package:ibiapabaapp/shared/ui/fragments/toast/show_app_toast.dart';
import 'package:ibiapabaapp/shared/ui/layout/section_header.dart';
import 'package:ibiapabaapp/shared/ui/layout/vertical_items_list.dart';

final List<Business> _mockCompanies = List.generate(
  5,
  (index) => Business(
    id: 'mock-$index',
    slug: 'mock',
    name: 'Carregando empresa',
    maxReachLevel: ReachLevel.regional,
    categories: ['Categoria', 'Subcategoria'],
    createdAt: DateTime.now(),
  ),
);

class BusinessesOverviewScreen extends ConsumerStatefulWidget {
  const BusinessesOverviewScreen({super.key});

  @override
  ConsumerState<BusinessesOverviewScreen> createState() =>
      _BusinessesOverviewScreenState();
}

class _BusinessesOverviewScreenState
    extends ConsumerState<BusinessesOverviewScreen> {
  @override
  Widget build(BuildContext context) {
    final businessesAsync = ref.watch(businessesProvider);

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
                showAppToast(
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
          child: businessesAsync.when(
            skipLoadingOnRefresh: false,

            loading: () =>
                _Content(businesses: _mockCompanies, isLoading: true),

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

            data: (businesses) =>
                _Content(businesses: businesses, isLoading: false),
          ),
        ),
      ],
    );
  }
}

class _Content extends StatelessWidget {
  final List<Business> businesses;
  final bool isLoading;

  const _Content({required this.businesses, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            spacing: 8,
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
              FittedBox(
                alignment: Alignment.centerLeft,
                child: FButton(
                  style: FButtonStyle.secondary(),
                  onPress: () => (),
                  child: Row(
                    spacing: 4,
                    children: const [Icon(Icons.refresh), Text('Atualizar')],
                  ),
                ),
              ),
            ],
          ),
        ),

        _Section(
          businesses: businesses,
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
  final List<Business> businesses;

  const _Section({
    required this.businesses,
    required this.header,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8,
        children: [
          header,
          VerticalItemsList(
            isLoading: isLoading,
            items: businesses,
            separator: const SizedBox(height: 16),
            itemBuilder: (_, business) => BusinessCard(business: business),
          ),
        ],
      ),
    );
  }
}
