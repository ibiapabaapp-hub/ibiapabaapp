import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class AvailabilitySuffix extends StatelessWidget {
  final bool? isAvailable;
  final bool isChecking;

  const AvailabilitySuffix({
    super.key,
    required this.isAvailable,
    this.isChecking = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isChecking) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: SizedBox.square(
          dimension: 14,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: context.theme.colors.foreground,
          ),
        ),
      );
    }

    if (isAvailable == null) {
      return const SizedBox.shrink();
    }
    final theme = context.theme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Icon(
        isAvailable! ? Icons.check : Icons.close,
        size: 18,
        color: isAvailable! ? theme.colors.primary : theme.colors.destructive,
      ),
    );
  }
}
