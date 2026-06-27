import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

// ignore_for_file: unnecessary_ignore
// ignore_for_file: avoid_redundant_argument_values

FMultiSelectFieldStyle multiSelectFieldStyle({
  required FColors colors,
  required FTypography typography,
  required FStyle style,
}) {
  final label = _labelStyles(style: style).verticalStyle;
  final ghost = _buttonStyles(
    colors: colors,
    typography: typography,
    style: style,
  ).ghost;
  return .new(
    decoration: FWidgetStateMap({
      WidgetState.error: BoxDecoration(
        border: .all(color: colors.error, width: style.borderWidth),
        borderRadius: .circular(12),
      ),
      WidgetState.disabled: BoxDecoration(
        border: .all(
          color: colors.disable(colors.border),
          width: style.borderWidth,
        ),
        borderRadius: .circular(12),
      ),
      WidgetState.focused: BoxDecoration(
        border: .all(color: colors.primary, width: style.borderWidth),
        borderRadius: .circular(12),
      ),
      WidgetState.any: BoxDecoration(
        border: .all(color: colors.border, width: style.borderWidth),
        borderRadius: .circular(12),
      ),
    }),
    hintTextStyle: FWidgetStateMap({
      WidgetState.disabled: typography.sm.copyWith(
        color: colors.disable(colors.border),
      ),
      WidgetState.any: typography.sm.copyWith(color: colors.mutedForeground),
    }),
    iconStyle: IconThemeData(color: colors.mutedForeground, size: 18),
    clearButtonStyle: ghost.copyWith(
      iconContentStyle: ghost.iconContentStyle
          .copyWith(
            iconStyle: FWidgetStateMap({
              WidgetState.disabled: IconThemeData(
                color: colors.disable(colors.mutedForeground),
                size: 17,
              ),
              WidgetState.any: IconThemeData(
                color: colors.mutedForeground,
                size: 17,
              ),
            }),
          )
          .call,
    ),
    tappableStyle: style.tappableStyle.copyWith(
      motion: FTappableMotion.none.call,
    ),
    labelTextStyle: style.formFieldStyle.labelTextStyle,
    descriptionTextStyle: style.formFieldStyle.descriptionTextStyle,
    errorTextStyle: style.formFieldStyle.errorTextStyle,
    labelPadding: label.labelPadding,
    descriptionPadding: label.descriptionPadding,
    errorPadding: label.errorPadding,
    childPadding: label.childPadding,
  );
}

FLabelStyles _labelStyles({required FStyle style}) => FLabelStyles(
  horizontalStyle: .inherit(
    style: style,
    descriptionPadding: const .only(top: 2),
    errorPadding: const .only(top: 2),
    childPadding: const .symmetric(horizontal: 8),
  ),
  verticalStyle: .inherit(
    style: style,
    labelPadding: const .only(bottom: 5),
    descriptionPadding: const .only(top: 5),
    errorPadding: const .only(top: 5),
  ),
);

FButtonStyles _buttonStyles({
  required FColors colors,
  required FTypography typography,
  required FStyle style,
}) => FButtonStyles(
  primary: .inherit(
    colors: colors,
    style: style,
    typography: typography,
    color: colors.primary,
    foregroundColor: colors.primaryForeground,
  ),
  secondary: .inherit(
    colors: colors,
    style: style,
    typography: typography,
    color: colors.secondary,
    foregroundColor: colors.secondaryForeground,
  ),
  destructive: .inherit(
    colors: colors,
    style: style,
    typography: typography,
    color: colors.destructive,
    foregroundColor: colors.destructiveForeground,
  ),
  outline: FButtonStyle(
    decoration: FWidgetStateMap({
      WidgetState.disabled: BoxDecoration(
        border: .all(color: colors.disable(colors.border)),
        borderRadius: style.borderRadius,
      ),
      WidgetState.hovered | WidgetState.pressed: BoxDecoration(
        border: .all(color: colors.border),
        borderRadius: style.borderRadius,
        color: colors.secondary,
      ),
      WidgetState.any: BoxDecoration(
        border: .all(color: colors.border),
        borderRadius: style.borderRadius,
      ),
    }),
    focusedOutlineStyle: style.focusedOutlineStyle,
    contentStyle: .inherit(
      typography: typography,
      enabled: colors.secondaryForeground,
      disabled: colors.disable(colors.secondaryForeground),
    ),
    iconContentStyle: .inherit(
      enabled: colors.secondaryForeground,
      disabled: colors.disable(colors.secondaryForeground),
    ),
    tappableStyle: style.tappableStyle,
  ),
  ghost: FButtonStyle(
    decoration: FWidgetStateMap({
      WidgetState.disabled: BoxDecoration(borderRadius: style.borderRadius),
      WidgetState.hovered | WidgetState.pressed: BoxDecoration(
        borderRadius: style.borderRadius,
        color: colors.secondary,
      ),
      WidgetState.any: BoxDecoration(borderRadius: style.borderRadius),
    }),
    focusedOutlineStyle: style.focusedOutlineStyle,
    contentStyle: .inherit(
      typography: typography,
      enabled: colors.secondaryForeground,
      disabled: colors.disable(colors.secondaryForeground),
    ),
    iconContentStyle: .inherit(
      enabled: colors.secondaryForeground,
      disabled: colors.disable(colors.secondaryForeground),
    ),
    tappableStyle: style.tappableStyle,
  ),
);
