import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

// ignore_for_file: unnecessary_ignore
// ignore_for_file: avoid_redundant_argument_values

FDialogStyle dialogStyle({
  required FStyle style,
  required FColors colors,
  required FTypography typography,
}) {
  final title = typography.lg.copyWith(
    fontWeight: .w600,
    color: colors.foreground,
  );
  final body = typography.sm.copyWith(color: colors.mutedForeground);
  return .new(
    decoration: BoxDecoration(
      border: BoxBorder.all(color: colors.border, width: 0.5, style: .solid),
      borderRadius: style.borderRadius,
      color: colors.background,
    ),
    horizontalStyle: FDialogContentStyle(
      titleTextStyle: title,
      bodyTextStyle: body,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      actionSpacing: 8,
    ),
    verticalStyle: FDialogContentStyle(
      titleTextStyle: title,
      bodyTextStyle: body,
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
      actionSpacing: 8,
    ),
  );
}
