import 'package:forui/forui.dart';
import 'package:ibivibe/app/theme/adapted_styles/multi_select_field_style.dart';

// ignore_for_file: unnecessary_ignore
// ignore_for_file: avoid_redundant_argument_values

FMultiSelectStyle multiSelectStyle({
  required FColors colors,
  required FTypography typography,
  required FStyle style,
}) => FMultiSelectStyle(
  fieldStyle: multiSelectFieldStyle(
    colors: colors,
    typography: typography,
    style: style,
  ),
  tagStyle: .inherit(colors: colors, typography: typography, style: style),
  searchStyle: .inherit(colors: colors, typography: typography, style: style),
  contentStyle: .inherit(
    colors: colors,
    typography: typography,
    style: style.copyWith(borderRadius: .circular(12)),
  ),
  emptyTextStyle: typography.sm,
);
