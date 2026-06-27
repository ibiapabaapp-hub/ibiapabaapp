import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:ibivibe/shared/ui/fragments/inputs/tappable_container.dart';
import 'package:ibivibe/shared/ui/layout/section_header.dart';

class ItemsGrid extends StatelessWidget {
  final String title;
  final int crossAxisCount;
  final List<String> items;
  final void Function(String category)? onItemTap;
  final void Function() onSeeAllTap;

  const ItemsGrid({
    super.key,
    this.onItemTap,
    required this.items,
    this.crossAxisCount = 2,
    required this.title,
    required this.onSeeAllTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        SectionHeader(title: title, onSeeAllTap: onSeeAllTap),
        const SizedBox(height: 16),

        LayoutBuilder(
          builder: (context, constraints) {
            const double spacing = 8.0;
            final double itemWidth =
                (constraints.maxWidth - spacing) / crossAxisCount;

            return Wrap(
              spacing: spacing,
              runSpacing: spacing,
              children: items.map((category) {
                return SizedBox(
                  width: itemWidth,
                  height: 64,
                  child: TappableContainer(
                    color: context.theme.colors.secondary,
                    borderRadius: BorderRadius.circular(16),
                    onTap: () => onItemTap?.call(category),
                    child: Center(
                      child: Text(
                        category,
                        textAlign: TextAlign.center,
                        style: context.theme.typography.sm,
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}
