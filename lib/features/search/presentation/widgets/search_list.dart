import 'package:flutter/material.dart';
import 'package:ibivibe/features/search/domain/entities/search_result.dart';
import 'package:ibivibe/features/search/presentation/widgets/search_item.dart';

class SearchList extends StatelessWidget {
  final List<SearchResult> results;

  const SearchList({super.key, required this.results});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
      itemCount: results.length,
      separatorBuilder: (context, index) => const Divider(
        height: 8,
        indent: 16,
        endIndent: 16,
        color: Colors.transparent,
      ),
      itemBuilder: (context, index) {
        final result = results[index];
        return SearchItem(result: result);
      },
    );
  }
}
