import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

FBadgeStyle getInvertedBadgeStyle(FColors colors, FTypography typography) {
  return FBadgeStyle(
    decoration: BoxDecoration(
      color: colors.foreground,
      borderRadius: FBadgeStyles.defaultRadius,
    ),
    contentStyle: FBadgeContentStyle(
      padding: const .symmetric(horizontal: 8, vertical: 4),
      labelTextStyle: typography.sm.copyWith(
        color: colors.background,
        fontWeight: .w500,
      ),
    ),
  );
}
