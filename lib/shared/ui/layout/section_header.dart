import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final Function? onSeeAllTap;
  final String seeAllText;

  const SectionHeader({
    super.key,
    required this.title,
    required this.onSeeAllTap,
    this.seeAllText = 'Ver tudo',
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      crossAxisAlignment: .center,
      children: [
        GestureDetector(
          onTap: () => onSeeAllTap?.call(),
          child: Text(
            title,
            style: context.theme.typography.base.copyWith(fontWeight: .w600),
            strutStyle: const StrutStyle(leading: 1.2),
          ),
        ),

        if (onSeeAllTap != null)
          FButton.raw(
            onPress: () => onSeeAllTap?.call(),
            style: FButtonStyle.ghost(),
            child: Text(
              seeAllText,
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
