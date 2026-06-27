import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

FTabsStyle tabsStyle({
  required FColors colors,
  required FTypography typography,
  required FStyle style,
}) => FTabsStyle(
  decoration: BoxDecoration(
    border: .all(color: colors.muted),
    borderRadius: .circular(16),
    color: colors.muted,
  ),
  selectedLabelTextStyle: typography.sm.copyWith(
    fontWeight: .w500,
    fontFamily: typography.defaultFontFamily,
    color: colors.foreground,
  ),
  unselectedLabelTextStyle: typography.sm.copyWith(
    fontWeight: .w500,
    fontFamily: typography.defaultFontFamily,
    color: colors.mutedForeground,
  ),
  indicatorDecoration: BoxDecoration(
    color: colors.background,
    borderRadius: .circular(16),
    border: .all(color: colors.muted),
  ),
  focusedOutlineStyle: FFocusedOutlineStyle(
    color: colors.background,
    borderRadius: .circular(16),
  ),
  padding: const .all(4),
  indicatorSize: .tab,
  height: 36,
  spacing: 16,
);
