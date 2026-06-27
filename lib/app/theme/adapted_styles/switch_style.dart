import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

// ignore_for_file: unnecessary_ignore
// ignore_for_file: avoid_redundant_argument_values

FSwitchStyle switchStyle({required FColors colors, required FStyle style}) {
  final label = _labelStyles(style: style).horizontalStyle;
  return .new(
    focusColor: colors.primary.withAlpha(200),
    trackColor: FWidgetStateMap({
      WidgetState.disabled & WidgetState.selected: colors.disable(
        colors.primary.withAlpha(200),
      ),
      WidgetState.disabled: colors.disable(colors.border),
      WidgetState.selected: colors.primary.withAlpha(200),
      WidgetState.any: colors.border,
    }),
    thumbColor: .all(Colors.white),
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
