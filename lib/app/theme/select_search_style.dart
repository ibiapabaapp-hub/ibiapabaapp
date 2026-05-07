import 'package:flutter/material.dart';

import 'package:forui/forui.dart';
import 'package:ibiapabaapp/app/theme/text_field_style.dart';

FSelectSearchStyle selectSearchStyle({
  required FColors colors,
  required FTypography typography,
  required FStyle style,
}) => FSelectSearchStyle(
  textFieldStyle: textFieldStyle(
    colors: colors,
    typography: typography,
    style: style,
  ),
  iconStyle: IconThemeData(size: 15, color: colors.mutedForeground),
  dividerStyle: _dividerStyles(
    colors: colors,
    style: style,
  ).horizontalStyle.copyWith(width: 2, padding: .zero),
  progressStyle: .inherit(colors: colors),
);

FDividerStyles _dividerStyles({
  required FColors colors,
  required FStyle style,
}) => FDividerStyles(
  horizontalStyle: FDividerStyle(
    color: colors.secondary,
    padding: FDividerStyle.defaultPadding.horizontalStyle,
    width: style.borderWidth,
  ),
  verticalStyle: FDividerStyle(
    color: colors.secondary,
    padding: FDividerStyle.defaultPadding.verticalStyle,
    width: style.borderWidth,
  ),
);
