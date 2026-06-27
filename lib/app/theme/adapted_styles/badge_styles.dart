import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

// ignore_for_file: unnecessary_ignore
// ignore_for_file: avoid_redundant_argument_values
FBadgeStyles badgeStyles({
  required FColors colors,
  required FTypography typography,
  required FStyle style,
}) => FBadgeStyles(
  primary: FBadgeStyle(
    decoration: BoxDecoration(
      color: colors.primary,
      borderRadius: FBadgeStyles.defaultRadius,
    ),
    contentStyle: FBadgeContentStyle(
      labelTextStyle: typography.sm.copyWith(
        color: colors.primaryForeground,
        fontWeight: .w500,
      ),
    ),
  ),
  secondary: FBadgeStyle(
    decoration: BoxDecoration(
      color: colors.secondary,
      borderRadius: FBadgeStyles.defaultRadius,
    ),
    contentStyle: FBadgeContentStyle(
      labelTextStyle: typography.sm.copyWith(
        color: colors.secondaryForeground,
        fontWeight: .w500,
      ),
    ),
  ),
  outline: FBadgeStyle(
    decoration: BoxDecoration(
      border: Border.all(color: colors.border, width: style.borderWidth),
      borderRadius: FBadgeStyles.defaultRadius,
    ),
    contentStyle: FBadgeContentStyle(
      labelTextStyle: typography.sm.copyWith(
        color: colors.foreground,
        fontWeight: .w500,
      ),
    ),
  ),
  destructive: FBadgeStyle(
    decoration: BoxDecoration(
      color: colors.destructive,
      borderRadius: FBadgeStyles.defaultRadius,
    ),
    contentStyle: FBadgeContentStyle(
      labelTextStyle: typography.sm.copyWith(
        color: colors.destructiveForeground,
        fontWeight: .w500,
      ),
    ),
  ),
);
