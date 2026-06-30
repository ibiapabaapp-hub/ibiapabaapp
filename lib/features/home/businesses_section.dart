import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:ibivibe/shared/models/business.dart';
import 'package:ibivibe/features/businesses/businesses_viewmodel.dart';
import 'package:ibivibe/features/businesses/business_card.dart';
import 'package:ibivibe/shared/ui/layout/section_header.dart';
import 'package:ibivibe/shared/ui/layout/vertical_items_list.dart';

final List<Business> _mockCompanies = List.generate(
  5,
  (index) => Business(
    id: 'mock-$index',
    maxReachLevel: .local,
    slug: 'mock',
    name: 'Carregando empresa',
    categories: ['Categoria', 'Subcategoria'],
    createdAt: DateTime.now(),
  ),
);

class CompaniesSection extends ConsumerStatefulWidget {
  const CompaniesSection({super.key});

  @override
  ConsumerState<CompaniesSection> createState() => _CompaniesSectionState();
}

class _CompaniesSectionState extends ConsumerState<CompaniesSection> {
  @override
  Widget build(BuildContext context) {
    final companiesAsync = ref.watch(businessesViewModelProvider);

    return Column(
      mainAxisAlignment: .start,
      crossAxisAlignment: .start,
      spacing: 8,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: SectionHeader(
            title: 'Explore as empresas da Ibiapaba',
            onSeeAllTap: () => context.push('/app/businesses'),
          ),
        ),
        companiesAsync.when(
          skipLoadingOnRefresh: false,
          loading: () => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: VerticalItemsList(
              isLoading: true,
              items: _mockCompanies,
              separator: const SizedBox(height: 24),
              itemBuilder: (_, c) => BusinessCard(business: c),
            ),
          ),

          error: (error, stack) => Expanded(
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
                  'Erro ao carregar empresas',
                  style: context.theme.typography.base,
                ),
              ],
            ),
          ),

          data: (businesses) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: VerticalItemsList(
              isLoading: false,
              separator: const SizedBox(height: 24),
              items: businesses,
              itemBuilder: (_, c) => BusinessCard(business: c),
            ),
          ),
        ),
      ],
    );
  }
}
