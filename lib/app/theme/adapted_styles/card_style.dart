import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

// ignore_for_file: unnecessary_ignore
// ignore_for_file: avoid_redundant_argument_values

FCardStyle cardStyle({
  required FColors colors,
  required FTypography typography,
  required FStyle style,
}) => FCardStyle(
  decoration: BoxDecoration(
    border: .all(color: colors.border),
    borderRadius: style.borderRadius,
    color: colors.secondary.withAlpha(128),
  ),
  contentStyle: FCardContentStyle(
    titleTextStyle: typography.xl2.copyWith(
      fontWeight: .w600,
      color: colors.foreground,
      height: 1.5,
    ),
    subtitleTextStyle: typography.sm.copyWith(color: colors.mutedForeground),
  ),
);
