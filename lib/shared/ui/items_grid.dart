import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:ibiapabaapp/shared/ui/tappable_container.dart';

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

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            FButton.raw(
              onPress: () => onSeeAllTap.call(),
              style: FButtonStyle.ghost(),
              child: Text(
                'Ver tudo',
                style: TextStyle(
                  color: context.theme.colors.mutedForeground,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
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
                  height: 72,
                  child: TappableContainer(
                    color: context.theme.colors.secondary,
                    borderRadius: BorderRadius.circular(16),
                    onTap: () => onItemTap?.call(category),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          category,
                          textAlign: TextAlign.center,
                          softWrap: true,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
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
