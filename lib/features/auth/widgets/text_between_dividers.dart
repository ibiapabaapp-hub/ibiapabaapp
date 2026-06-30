import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class TextBetweenDividers extends StatelessWidget {
  final String text;
  const TextBetweenDividers({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .spaceBetween,
      mainAxisSize: .max,
      spacing: 8,
      children: [
        Expanded(
          child: FDivider(
            axis: .horizontal,
            style: FDividerStyle(
              color: context.theme.colors.border,
              padding: const .all(0),
            ).call,
          ),
        ),
        Text(
          text,
          style: context.theme.typography.sm.copyWith(
            color: context.theme.colors.mutedForeground,
          ),
        ),
        Expanded(
          child: FDivider(
            axis: .horizontal,
            style: FDividerStyle(
              color: context.theme.colors.border,
              padding: const .all(0),
            ).call,
          ),
        ),
      ],
    );
  }
}
