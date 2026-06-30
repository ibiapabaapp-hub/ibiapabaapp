import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class SearchSuggestionSection extends StatelessWidget {
  const SearchSuggestionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Text(
          'Sugestões',
          style: context.theme.typography.sm.copyWith(
            color: context.theme.colors.mutedForeground,
            fontWeight: .w500,
          ),
        ),

        Text(
          'Estamos trabalhando para trazer sugestões inteligentes para você.',
          style: context.theme.typography.sm.copyWith(
            color: context.theme.colors.mutedForeground,
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
