import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:ibivibe/features/accounts/transform_account_interests.dart';
import 'package:ibivibe/shared/models/tag_group.dart';
import 'package:ibivibe/features/tags/providers/tags_providers.dart';
import 'package:ibivibe/features/accounts/viewmodels/account_interests_viewmodel.dart';
import 'package:ibivibe/features/onboarding/widgets/interests_accordion.dart';
import 'package:ibivibe/shared/ui/fragments/effects/default_shimmer_effect.dart';
import 'package:skeletonizer/skeletonizer.dart';

final _mockTagGroups = [
  const TagGroup(id: 'mock-1', name: 'Carregando categoria'),
  const TagGroup(id: 'mock-2', name: 'Carregando categoria'),
  const TagGroup(id: 'mock-3', name: 'Carregando categoria'),
];

class AccountBusinessesInterestsScreen extends ConsumerStatefulWidget {
  const AccountBusinessesInterestsScreen({super.key});

  @override
  ConsumerState<AccountBusinessesInterestsScreen> createState() =>
      _AccountBusinessesInterestsScreenState();
}

class _AccountBusinessesInterestsScreenState
    extends ConsumerState<AccountBusinessesInterestsScreen> {
  Set<String> _selected = {};
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final interests = ref
        .read(accountInterestsViewModelProvider)
        .interestsData;
    _selected = getInterestsIdsSet(interests);
  }

  void _handleChanged(Set<String> selected) {
    setState(() => _selected = selected);
  }

  void _handleSkip() async {
    setState(() => _isLoading = true);
    try {
      await ref
          .read(accountInterestsViewModelProvider.notifier)
          .saveInterests(selected: [], entityType: InterestEntityType.business);
      if (mounted) context.push('/app/interests/events');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _handleComplete() async {
    setState(() => _isLoading = true);
    try {
      await ref
          .read(accountInterestsViewModelProvider.notifier)
          .saveInterests(
            selected: _selected.toList(),
            entityType: InterestEntityType.business,
          );

      if (mounted) context.push('/app/interests/events');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final tagGroupsAsync = ref.watch(tagGroupsProvider);

    return SafeArea(
      child: FScaffold(
        header: FHeader.nested(
          prefixes: [
            FButton.icon(
              style: FButtonStyle.ghost(),
              onPress: context.pop,
              child: const Icon(FIcons.arrowLeft),
            ),
          ],
        ),
        footer: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisSize: .max,
            mainAxisAlignment: .spaceBetween,
            spacing: 16,
            children: [
              Expanded(
                child: FButton(
                  style: FButtonStyle.outline(),
                  onPress: _handleSkip,
                  child: const Text('Pular'),
                ),
              ),
              Expanded(
                child: FButton(
                  onPress: _selected.isNotEmpty && !_isLoading
                      ? _handleComplete
                      : null,
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Continuar'),
                ),
              ),
            ],
          ),
        ),
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.all(0),
              sliver: SliverList.list(
                children: [
                  Text(
                    'Quais são seus interesses?',
                    style: context.theme.typography.xl2.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Selecione as categorias para personalizarmos sua experiência',
                    style: context.theme.typography.base.copyWith(
                      color: context.theme.colors.mutedForeground,
                    ),
                  ),
                  const SizedBox(height: 24),
                  tagGroupsAsync.when(
                    skipLoadingOnRefresh: false,
                    loading: () => Skeletonizer(
                      effect: customShimmerEffect(context),
                      child: InterestsAccordion(
                        tagGroups: _mockTagGroups,
                        initialSelected: _selected,
                        onChanged: _handleChanged,
                      ),
                    ),
                    error: (error, stack) => Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 16,
                        children: [
                          Icon(
                            Icons.error_outline,
                            color: context.theme.colors.mutedForeground,
                            size: 64,
                          ),
                          Text(
                            'Erro ao carregar categorias',
                            style: context.theme.typography.base,
                          ),
                        ],
                      ),
                    ),
                    data: (tagGroups) => InterestsAccordion(
                      tagGroups: tagGroups,
                      initialSelected: _selected,
                      onChanged: _handleChanged,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
