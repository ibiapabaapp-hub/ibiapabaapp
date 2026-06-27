import 'package:flutter/services.dart';
import 'package:forui/forui.dart';
import 'package:flutter/material.dart';
import 'package:ibivibe/app/theme/adapted_styles/badge_styles.dart';
import 'package:ibivibe/app/theme/adapted_styles/button_style.dart';
import 'package:ibivibe/app/theme/adapted_styles/card_style.dart';
import 'package:ibivibe/app/theme/adapted_styles/date_field_style.dart';
import 'package:ibivibe/app/theme/adapted_styles/dialog_style.dart';
import 'package:ibivibe/app/theme/adapted_styles/divider_styles.dart';
import 'package:ibivibe/app/theme/adapted_styles/multi_select_style.dart';
import 'package:ibivibe/app/theme/adapted_styles/scaffold_style.dart';
import 'package:ibivibe/app/theme/adapted_styles/select_style.dart';
import 'package:ibivibe/app/theme/adapted_styles/switch_style.dart';
import 'package:ibivibe/app/theme/adapted_styles/tabs_style.dart';
import 'package:ibivibe/app/theme/adapted_styles/text_field_style.dart';
import 'package:ibivibe/app/theme/adapted_styles/tile_group_style.dart';
import 'package:ibivibe/app/theme/adapted_styles/tile_style.dart';

const brandPrimaryLight = Color(0xFF376208);
const brandPrimaryDark = Color(0xFFB9FF70);

FThemeData customZincLight() {
  const colors = FColors(
    brightness: Brightness.light,
    systemOverlayStyle: SystemUiOverlayStyle.dark,
    barrier: Color.fromARGB(160, 0, 0, 0),
    background: Color(0xFFFFFFFF),
    foreground: Color(0xFF09090B),
    primary: brandPrimaryLight,
    primaryForeground: Colors.white,
    secondary: Color(0xFFF4F4F5),
    secondaryForeground: Color(0xFF18181B),
    muted: Color(0xFFF4F4F5),
    mutedForeground: Color(0xFF71717A),
    destructive: Color(0xFFEF4444),
    destructiveForeground: Color(0xFFFAFAFA),
    error: Color.fromARGB(255, 171, 50, 50),
    errorForeground: Color(0xFFFAFAFA),
    border: Color(0xFFCCCCCC),
  );

  final typography = _typography(colors: colors);
  final style = _style(colors: colors, typography: typography);

  return FThemeData(
    colors: colors,
    typography: typography,
    style: style,
    textFieldStyle: textFieldStyle(
      colors: colors,
      style: style,
      typography: typography,
    ),
    buttonStyles: getButtonStyles(
      colors: colors,
      typography: typography,
      style: style,
    ),
    dateFieldStyle: dateFieldStyle(
      colors: colors,
      typography: typography,
      style: style,
    ),
    tileStyle: tileStyle(colors: colors, typography: typography, style: style),
    tileGroupStyle: tileGroupStyle(
      colors: colors,
      typography: typography,
      style: style,
    ),
    switchStyle: switchStyle(colors: colors, style: style),
    dialogStyle: dialogStyle(
      style: style,
      colors: colors,
      typography: typography,
    ),
    selectStyle: selectStyle(
      colors: colors,
      typography: typography,
      style: style,
    ),
    multiSelectStyle: multiSelectStyle(
      colors: colors,
      typography: typography,
      style: style,
    ),
    cardStyle: cardStyle(colors: colors, typography: typography, style: style),
    dividerStyles: dividerStyles(colors: colors, style: style),
    badgeStyles: badgeStyles(
      colors: colors,
      typography: typography,
      style: style,
    ),
    tabsStyle: tabsStyle(colors: colors, typography: typography, style: style),
    scaffoldStyle: scaffoldStyle(colors: colors, style: style),
  );
}

FThemeData customZincDark() {
  const colors = FColors(
    brightness: Brightness.dark,
    systemOverlayStyle: SystemUiOverlayStyle.light,
    barrier: Color.fromARGB(160, 0, 0, 0),
    background: Color(0xFF18181B),
    foreground: Color(0xFFFFFFFF),
    primary: brandPrimaryDark,
    primaryForeground: Colors.black,
    secondary: Color(0xFF27272A),
    secondaryForeground: Color(0xFFF4F4F5),
    muted: Color(0xFF27272A),
    mutedForeground: Color(0xFF71717A),
    destructive: Color(0xFFEF4444),
    destructiveForeground: Color(0xFFFAFAFA),
    error: Color.fromARGB(255, 232, 91, 91),
    errorForeground: Color(0xFFFAFAFA),
    border: Color(0xFF4D4D56),
  );

  final typography = _typography(colors: colors);
  final style = _style(colors: colors, typography: typography);

  return FThemeData(
    colors: colors,
    typography: typography,
    style: style,
    textFieldStyle: textFieldStyle(
      colors: colors,
      style: style,
      typography: typography,
    ),
    buttonStyles: getButtonStyles(
      colors: colors,
      typography: typography,
      style: style,
    ),
    dateFieldStyle: dateFieldStyle(
      colors: colors,
      typography: typography,
      style: style,
    ),
    tileStyle: tileStyle(colors: colors, typography: typography, style: style),
    tileGroupStyle: tileGroupStyle(
      colors: colors,
      typography: typography,
      style: style,
    ),
    switchStyle: switchStyle(colors: colors, style: style),
    dialogStyle: dialogStyle(
      style: style,
      colors: colors,
      typography: typography,
    ),
    selectStyle: selectStyle(
      colors: colors,
      typography: typography,
      style: style,
    ),
    multiSelectStyle: multiSelectStyle(
      colors: colors,
      typography: typography,
      style: style,
    ),
    cardStyle: cardStyle(colors: colors, typography: typography, style: style),
    dividerStyles: dividerStyles(colors: colors, style: style),
    badgeStyles: badgeStyles(
      colors: colors,
      typography: typography,
      style: style,
    ),
    tabsStyle: tabsStyle(colors: colors, typography: typography, style: style),
    scaffoldStyle: scaffoldStyle(colors: colors, style: style),
  );
}

FTypography _typography({
  required FColors colors,
  String defaultFontFamily = 'DMSans',
}) => FTypography(
  xs: TextStyle(
    color: colors.foreground,
    fontFamily: defaultFontFamily,
    fontSize: 12,
    height: 1,
  ),
  sm: TextStyle(
    color: colors.foreground,
    fontFamily: defaultFontFamily,
    fontSize: 14,
    height: 1.25,
  ),
  base: TextStyle(
    color: colors.foreground,
    fontFamily: defaultFontFamily,
    fontSize: 16,
    height: 1.25,
  ),
  lg: TextStyle(
    color: colors.foreground,
    fontFamily: defaultFontFamily,
    fontSize: 18,
    height: 1.15,
  ),
  xl: TextStyle(
    color: colors.foreground,
    fontFamily: defaultFontFamily,
    fontSize: 20,
    height: 1.25,
  ),
  xl2: TextStyle(
    color: colors.foreground,
    fontFamily: defaultFontFamily,
    fontSize: 24,
    height: 1.35,
  ),
  xl3: TextStyle(
    color: colors.foreground,
    fontFamily: defaultFontFamily,
    fontSize: 30,
    height: 1.45,
  ),
  xl4: TextStyle(
    color: colors.foreground,
    fontFamily: defaultFontFamily,
    fontSize: 36,
    height: 1.55,
  ),
  xl5: TextStyle(
    color: colors.foreground,
    fontFamily: defaultFontFamily,
    fontSize: 48,
    height: 1.65,
  ),
  xl6: TextStyle(
    color: colors.foreground,
    fontFamily: defaultFontFamily,
    fontSize: 60,
    height: 1.75,
  ),
  xl7: TextStyle(
    color: colors.foreground,
    fontFamily: defaultFontFamily,
    fontSize: 72,
    height: 1.85,
  ),
  xl8: TextStyle(
    color: colors.foreground,
    fontFamily: defaultFontFamily,
    fontSize: 96,
    height: 1.95,
  ),
);

FStyle _style({
  required FColors colors,
  required FTypography typography,
}) => FStyle(
  formFieldStyle:
      FFormFieldStyle.inherit(colors: colors, typography: typography).copyWith(
        labelTextStyle: FWidgetStateMap.all(
          TextStyle(color: colors.foreground, fontWeight: .w500),
        ),
      ),
  focusedOutlineStyle: FFocusedOutlineStyle(
    color: colors.primary,
    borderRadius: FLerpBorderRadius.circular(24),
  ),
  iconStyle: IconThemeData(color: colors.primary, size: 20),
  tappableStyle: FTappableStyle(),
  borderRadius: FLerpBorderRadius.circular(24),
  borderWidth: 1,
  shadow: const [
    BoxShadow(color: Color(0x0d000000), offset: Offset(0, 1), blurRadius: 2),
  ],
);

extension AppTextFieldOverrides on FTextFieldStyle {
  FTextFieldStyle withAppOverrides({
    required FColors colors,
    double? labelBottomPadding,
  }) {
    return copyWith(
      cursorColor: colors.primary,
      contentTextStyle: contentTextStyle,
      hintTextStyle: hintTextStyle,
      counterTextStyle: counterTextStyle,
      labelPadding: labelBottomPadding != null
          ? EdgeInsets.only(bottom: labelBottomPadding)
          : labelPadding,
    );
  }
}
