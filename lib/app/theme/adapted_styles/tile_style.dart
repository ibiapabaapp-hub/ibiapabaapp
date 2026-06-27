import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

// ignore_for_file: unnecessary_ignore
// ignore_for_file: avoid_redundant_argument_values

FTileStyle tileStyle({
  required FColors colors,
  required FTypography typography,
  required FStyle style,
}) => FTileStyle(
  backgroundColor: .all(colors.background),
  decoration: FWidgetStateMap({
    WidgetState.disabled: BoxDecoration(
      color: colors.disable(colors.secondary.withAlpha(128)),
      border: .all(color: colors.border),
      borderRadius: .circular(16),
    ),
    WidgetState.hovered | WidgetState.pressed: BoxDecoration(
      color: colors.secondary.withAlpha(128),
      border: .all(color: colors.border),
      borderRadius: .circular(16),
    ),
    WidgetState.any: BoxDecoration(
      color: colors.secondary.withAlpha(128),
      border: .all(color: colors.border),
      borderRadius: .circular(16),
    ),
  }),
  contentStyle: FItemContentStyle(
    padding: const .fromSTEB(16, 12, 10, 12),
    prefixIconStyle: FWidgetStateMap({
      WidgetState.disabled: IconThemeData(
        color: colors.disable(colors.foreground),
        size: 18,
      ),
      WidgetState.any: IconThemeData(color: colors.foreground, size: 18),
    }),
    titleTextStyle: FWidgetStateMap({
      WidgetState.disabled: typography.base.copyWith(
        color: colors.disable(colors.primary),
      ),
      WidgetState.any: typography.base,
    }),
    subtitleTextStyle: FWidgetStateMap({
      WidgetState.disabled: typography.xs.copyWith(
        color: colors.disable(colors.mutedForeground),
      ),
      WidgetState.any: typography.xs.copyWith(color: colors.mutedForeground),
    }),
    detailsTextStyle: FWidgetStateMap({
      WidgetState.disabled: typography.base.copyWith(
        color: colors.disable(colors.mutedForeground),
      ),
      WidgetState.any: typography.base.copyWith(color: colors.mutedForeground),
    }),
    suffixIconStyle: FWidgetStateMap({
      WidgetState.disabled: IconThemeData(
        color: colors.disable(colors.mutedForeground),
        size: 18,
      ),
      WidgetState.any: IconThemeData(color: colors.mutedForeground, size: 18),
    }),
  ),
  rawItemContentStyle: FRawItemContentStyle(
    padding: const .fromSTEB(16, 12, 10, 12),
    prefixIconStyle: FWidgetStateMap({
      WidgetState.disabled: IconThemeData(
        color: colors.disable(colors.foreground),
        size: 18,
      ),
      WidgetState.any: IconThemeData(color: colors.foreground, size: 18),
    }),
    childTextStyle: FWidgetStateMap({
      WidgetState.disabled: typography.base.copyWith(
        color: colors.disable(colors.primary),
      ),
      WidgetState.any: typography.base,
    }),
  ),
  tappableStyle: style.tappableStyle.copyWith(
    motion: FTappableMotion.none.call,
    pressedEnterDuration: .zero,
    pressedExitDuration: const Duration(milliseconds: 25),
  ),
  focusedOutlineStyle: style.focusedOutlineStyle,
  margin: EdgeInsets.zero,
);
