import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:ibiapabaapp/core/errors/failures/failures.dart';
import 'package:ibiapabaapp/features/search/presentation/providers/search_providers.dart';
import 'package:ibiapabaapp/features/search/presentation/providers/search_state_provider.dart';
import 'package:ibiapabaapp/features/search/presentation/widgets/recent_search_section.dart';
import 'package:ibiapabaapp/features/search/presentation/widgets/search_field_shell.dart';
import 'package:ibiapabaapp/features/search/presentation/widgets/search_list.dart';
import 'package:ibiapabaapp/features/search/presentation/widgets/search_suggestion_section.dart';

class ExpandedSearchScreen extends ConsumerStatefulWidget {
  const ExpandedSearchScreen({super.key});

  @override
  ConsumerState<ExpandedSearchScreen> createState() =>
      _ExpandedSearchScreenState();
}

class _ExpandedSearchScreenState extends ConsumerState<ExpandedSearchScreen>
    with SingleTickerProviderStateMixin {
  final _focusNode = FocusNode();
  late final AnimationController _contentAnim;
  late final Animation<double> _contentFade;
  late final Animation<Offset> _contentSlide;
  late final FTextFieldControl _searchControl;
  Timer? _debounce;
  String _query = '';

  void _onSearchChanged(String query) {
    setState(() => _query = query);
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (query.length >= 2) {
        ref.read(searchProvider.notifier).search(query);
        ref.read(searchStateProvider.notifier).addRecentSearch(query);
      } else if (query.isEmpty) {
        ref.read(searchProvider.notifier).search('');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _searchControl = FTextFieldControl.managed(
      onChange: (v) => _onSearchChanged(v.text),
    );
    _contentAnim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );

    _contentFade = CurvedAnimation(
      parent: _contentAnim,
      curve: const Interval(0.2, 1.0, curve: Curves.easeOut),
    );

    _contentSlide =
        Tween<Offset>(begin: const Offset(0, 0.06), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _contentAnim,
            curve: const Interval(0.2, 1.0, curve: Curves.easeOut),
          ),
        );

    // inicia após o Hero pousar (~300ms)
    Future.delayed(const Duration(milliseconds: 280), () {
      if (mounted) _contentAnim.forward();
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _contentAnim.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSuggestionTap(String query) {
    _onSearchChanged(query);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: context.theme.colors.background,
        body: Column(
          children: [
            SearchFieldShell(
              child: Row(
                spacing: 16,
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Icon(
                      Icons.arrow_back,
                      size: 24,
                      color: context.theme.colors.foreground,
                    ),
                  ),
                  Expanded(
                    child: FTextField(
                      control: _searchControl,
                      focusNode: _focusNode,
                      autofocus: true,
                      hint: 'O que vamos fazer hoje na Ibiapaba?',
                      style: (s) => s.copyWith(filled: true),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: FadeTransition(
                opacity: _contentFade,
                child: SlideTransition(
                  position: _contentSlide,
                  child: _SearchContent(
                    query: _query,
                    onSuggestionTap: _onSuggestionTap,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchContent extends ConsumerWidget {
  final String query;
  final ValueChanged<String> onSuggestionTap;

  const _SearchContent({required this.query, required this.onSuggestionTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchState = ref.watch(searchProvider);

    return searchState.when(
      data: (results) {
        if (results.isEmpty) {
          if (query.isEmpty) {
            return _buildSuggestions(context, ref);
          }
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.search_off,
                    size: 48,
                    color: context.theme.colors.mutedForeground,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Nenhum resultado encontrado para "$query"',
                    textAlign: TextAlign.center,
                    style: context.theme.typography.sm.copyWith(
                      color: context.theme.colors.mutedForeground,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return SearchList(results: results);
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) {
        final errorMessage = error is AppFailure
            ? error.message
            : error.toString();
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 48,
                  color: context.theme.colors.destructive,
                ),
                const SizedBox(height: 16),
                Text(
                  'Ocorreu um erro ao buscar resultados.',
                  style: context.theme.typography.base.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  errorMessage,
                  textAlign: TextAlign.center,
                  style: context.theme.typography.sm.copyWith(
                    color: context.theme.colors.mutedForeground,
                  ),
                ),
                const SizedBox(height: 16),
                FButton(
                  onPress: () =>
                      ref.read(searchProvider.notifier).search(query),
                  child: const Text('Tentar novamente'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSuggestions(BuildContext context, WidgetRef ref) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      children: [
        RecentSearchSection(onSuggestionTap: onSuggestionTap),
        const FDivider(),
        const SearchSuggestionSection(),
      ],
    );
  }
}
