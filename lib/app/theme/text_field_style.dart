import 'package:flutter/material.dart';

import 'package:forui/forui.dart';
import 'package:ibiapabaapp/app/theme/button_style.dart';

FTextFieldStyle textFieldStyle({
  required FColors colors,
  required FTypography typography,
  required FStyle style,
}) {
  final label = _labelStyles(style: style).verticalStyle;
  final ghost = getButtonStyles(
    colors: colors,
    typography: typography,
    style: style,
  ).ghost;

  final textStyle = typography.sm.copyWith(
    fontFamily: typography.defaultFontFamily,
    color: colors.foreground,
  );
  final buttonStyle = ghost.copyWith(
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
  );

  return .new(
    keyboardAppearance: colors.brightness,
    clearButtonStyle: buttonStyle,
    obscureButtonStyle: buttonStyle,
    contentTextStyle: FWidgetStateMap({
      WidgetState.disabled: textStyle.copyWith(
        color: colors.disable(colors.foreground),
      ),
      WidgetState.any: textStyle.copyWith(color: colors.foreground),
    }),
    hintTextStyle: FWidgetStateMap({
      WidgetState.disabled: textStyle.copyWith(
        color: colors.disable(colors.border),
      ),
      WidgetState.any: textStyle.copyWith(color: colors.mutedForeground),
    }),
    counterTextStyle: FWidgetStateMap({
      WidgetState.disabled: textStyle.copyWith(
        color: colors.disable(colors.primary),
      ),
      WidgetState.any: textStyle.copyWith(color: colors.primary),
    }),
    filled: true,
    fillColor: colors.barrier.withAlpha(128),
    cursorColor: colors.primary,
    border: FWidgetStateMap({
      WidgetState.error: OutlineInputBorder(
        borderSide: BorderSide(color: colors.error, width: style.borderWidth),
        borderRadius: .circular(12),
      ),
      WidgetState.disabled: OutlineInputBorder(
        borderSide: BorderSide(
          color: colors.disable(colors.border),
          width: style.borderWidth,
        ),
        borderRadius: .circular(12),
      ),
      WidgetState.focused: OutlineInputBorder(
        borderSide: BorderSide(color: colors.primary, width: style.borderWidth),
        borderRadius: .circular(12),
      ),
      WidgetState.any: OutlineInputBorder(
        borderSide: BorderSide(color: colors.border, width: style.borderWidth),
        borderRadius: .circular(12),
      ),
    }),
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
