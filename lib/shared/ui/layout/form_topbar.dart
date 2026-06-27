import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class FormTopbar extends StatelessWidget {
  final bool? invertColumn;
  final String? subtitle;
  final String title;
  const FormTopbar({
    super.key,
    this.subtitle,
    required this.title,
    this.invertColumn = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Column(
      spacing: 2,
      crossAxisAlignment: .start,
      verticalDirection: invertColumn == false ? .down : .up,
      children: [
        subtitle != null
            ? Text(
                subtitle!,
                style: context.theme.typography.base.copyWith(
                  color: theme.colors.mutedForeground,
                ),
              )
            : const SizedBox.shrink(),
        Text(
          title,
          style: context.theme.typography.xl2.copyWith(fontWeight: .w600),
        ),
      ],
    );
  }
}
