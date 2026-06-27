import 'package:flutter/material.dart';
import 'package:ibiapabaapp/shared/ui/fragments/effects/default_shimmer_effect.dart';
import 'package:skeletonizer/skeletonizer.dart';

typedef ListItemBuilder<T> = Widget Function(BuildContext context, T item);

class VerticalItemsList<T> extends StatelessWidget {
  final List<T> items;
  final ListItemBuilder<T> itemBuilder;
  final Widget separator;
  final bool isLoading;
  final EdgeInsetsGeometry? padding;

  const VerticalItemsList({
    super.key,
    required this.isLoading,
    required this.items,
    required this.separator,
    required this.itemBuilder,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      effect: customShimmerEffect(context),
      enabled: isLoading,
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: padding ?? EdgeInsets.zero,
        itemCount: isLoading ? 5 : (items.isEmpty ? 1 : items.length),
        separatorBuilder: (_, _) => separator,
        itemBuilder: (context, index) {
          if (isLoading) {
            return itemBuilder(
              context,
              items.isNotEmpty ? items[0] : _getDummyData(),
            );
          }
          if (items.isEmpty) {
            return _buildEmptyState();
          }
          return itemBuilder(context, items[index]);
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off_rounded, size: 48, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          const Text(
            'Nenhum evento encontrado',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  dynamic _getDummyData() => null;
}
