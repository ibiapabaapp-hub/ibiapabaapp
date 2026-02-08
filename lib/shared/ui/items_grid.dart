import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:ibiapabaapp/shared/ui/tap_scale_container.dart';

class ItemsGrid extends StatelessWidget {
  final String title;
  final int crossAxisCount;
  final List<String> items;
  final void Function(String category)? onTap;

  const ItemsGrid({
    super.key,
    this.onTap,
    required this.items,
    this.crossAxisCount = 2,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: .start,
      crossAxisAlignment: .start,
      spacing: 16,
      children: [
        const SizedBox.shrink(),
        Text(title, style: TextStyle(fontSize: 18, fontWeight: .w600)),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            mainAxisExtent: 72,
          ),
          itemBuilder: (context, index) {
            final category = items[index];

            return TapScaleContainer(
              color: context.theme.colors.secondary,
              borderRadius: BorderRadius.circular(16),
              onTap: () => onTap?.call(category),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Center(
                  child: Text(
                    category,
                    textAlign: TextAlign.center,
                    softWrap: true,
                    style: const TextStyle(fontFamily: 'DMSans', fontSize: 14),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
