import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:forui/forui.dart';
import 'package:ibivibe/app/theme/adapted_styles/tile_style.dart';

// ignore_for_file: unnecessary_ignore
// ignore_for_file: avoid_redundant_argument_values

FTileGroupStyle tileGroupStyle({
  required FColors colors,
  required FTypography typography,
  required FStyle style,
}) {
  final FTileStyle baseTileStyle = tileStyle(
    colors: colors,
    typography: typography,
    style: style,
  );
  return .new(
    decoration: BoxDecoration(
      border: Border.all(color: colors.border, width: style.borderWidth),
      borderRadius: .circular(16),
    ),
    tileStyle: baseTileStyle.copyWith(
      decoration: baseTileStyle.decoration.map(
        (d) => d == null
            ? null
            : BoxDecoration(
                color: d.color,
                image: d.image,
                boxShadow: d.boxShadow,
                gradient: d.gradient,
                backgroundBlendMode: d.backgroundBlendMode,
                shape: d.shape,
              ),
      ),
    ),
    dividerColor: .all(colors.border),
    dividerWidth: style.borderWidth,
    labelTextStyle: FWidgetStateMap({
      WidgetState.error: typography.base.copyWith(
        color:
            style.formFieldStyle.labelTextStyle.maybeResolve({})?.color ??
            colors.primary,
        fontWeight: .w400,
      ),
      WidgetState.disabled: typography.base.copyWith(
        color:
            style.formFieldStyle.labelTextStyle.maybeResolve({
              WidgetState.disabled,
            })?.color ??
            colors.disable(colors.primary),
        fontWeight: .w400,
      ),
      WidgetState.any: typography.base.copyWith(
        color:
            style.formFieldStyle.labelTextStyle.maybeResolve({})?.color ??
            colors.primary,
        fontWeight: .w400,
      ),
    }),
    descriptionTextStyle: style.formFieldStyle.descriptionTextStyle.map(
      (s) => typography.xs.copyWith(color: s.color),
    ),
    errorTextStyle: typography.xs.copyWith(
      color: style.formFieldStyle.errorTextStyle.color,
    ),
    labelPadding: const .fromSTEB(0, 0, 0, 10),
  );
}
