import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final Function? onSeeAllTap;
  const SectionHeader({
    super.key,
    required this.title,
    required this.onSeeAllTap,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      crossAxisAlignment: .center,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          strutStyle: StrutStyle(leading: 1.2),
        ),

        if (onSeeAllTap != null)
          FButton.raw(
            onPress: () => onSeeAllTap?.call(),
            style: FButtonStyle.ghost(),
            child: Text(
              'Ver tudo',
              style: context.theme.typography.sm.copyWith(
                fontWeight: .w500,
                color: context.theme.colors.mutedForeground,
              ),
            ),
          ),
      ],
    );
  }
}
