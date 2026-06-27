import 'package:flutter/material.dart';

import 'package:forui/forui.dart';
import 'package:ibivibe/app/theme/adapted_styles/select_search_style.dart';
import 'package:ibivibe/app/theme/adapted_styles/text_field_style.dart';

// ignore_for_file: unnecessary_ignore
// ignore_for_file: avoid_redundant_argument_values

FSelectStyle selectStyle({
  required FColors colors,
  required FTypography typography,
  required FStyle style,
}) => FSelectStyle(
  selectFieldStyle: textFieldStyle(
    colors: colors,
    typography: typography,
    style: style,
  ),
  iconStyle: IconThemeData(color: colors.mutedForeground, size: 18),
  searchStyle: selectSearchStyle(
    colors: colors,
    typography: typography,
    style: style,
  ),
  contentStyle: .inherit(
    colors: colors,
    typography: typography,
    style: style.copyWith(
      borderRadius: .circular(12),
      formFieldStyle: textFieldStyle(
        colors: colors,
        typography: typography,
        style: style,
      ).copyWith(fillColor: Colors.red, filled: true).call,
    ),
  ),
  emptyTextStyle: typography.sm,
);
