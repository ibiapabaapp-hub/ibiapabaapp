import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class RecentSearchItem extends StatelessWidget {
  final String query;
  final VoidCallback onTap;
  final VoidCallback onRemove;

  const RecentSearchItem({
    super.key,
    required this.query,
    required this.onTap,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: Row(
          children: [
            Icon(
              Icons.history,
              size: 20,
              color: context.theme.colors.mutedForeground,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                query,
                style: context.theme.typography.base.copyWith(
                  color: context.theme.colors.foreground,
                ),
              ),
            ),
            // TODO: animação suave de slide ao excluir
            InkWell(
              onTap: onRemove,
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.close,
                  size: 20,
                  color: context.theme.colors.mutedForeground,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
