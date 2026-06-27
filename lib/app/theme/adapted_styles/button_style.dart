import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

FButtonStyles getButtonStyles({
  required FColors colors,
  required FTypography typography,
  required FStyle style,
}) {
  return FButtonStyles.inherit(
    colors: colors,
    typography: typography,
    style: style,
  ).copyWith(
    // PRIMARY
    primary: (base) =>
        buttonStyle(
          colors: colors,
          typography: typography,
          style: style,
          color: colors.primary,
          foregroundColor: colors.primaryForeground,
        ).copyWith(
          contentStyle: base.contentStyle
              .copyWith(
                textStyle: FWidgetStateMap<TextStyle>.all(
                  TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: colors.primaryForeground,
                  ),
                ),
              )
              .call,
        ),
    secondary: (base) =>
        buttonStyle(
          colors: colors,
          typography: typography,
          style: style,
          color: colors.secondary,
          foregroundColor: colors.secondaryForeground,
        ).copyWith(
          contentStyle: base.contentStyle
              .copyWith(
                textStyle: FWidgetStateMap<TextStyle>.all(
                  const TextStyle(fontSize: 16),
                ),
              )
              .call,
        ),
    ghost: (base) =>
        buttonStyle(
          colors: colors,
          typography: typography,
          style: style,
          color: Colors.transparent,
          foregroundColor: colors.foreground,
        ).copyWith(
          contentStyle: base.contentStyle
              .copyWith(
                textStyle: FWidgetStateMap<TextStyle>.all(
                  const TextStyle(fontSize: 16),
                ),
              )
              .call,
        ),
    outline: (base) =>
        buttonStyle(
          colors: colors,
          typography: typography,
          style: style,
          color: Colors.transparent,
          foregroundColor: colors.foreground,
        ).copyWith(
          decoration: FWidgetStateMap.all(
            BoxDecoration(
              border: BoxBorder.all(color: colors.border),
              borderRadius: .circular(24),
              color: colors.secondary,
            ),
          ),
          contentStyle: base.contentStyle
              .copyWith(
                textStyle: FWidgetStateMap<TextStyle>.all(
                  const TextStyle(fontSize: 16),
                ),
              )
              .call,
        ),
    destructive: (base) =>
        buttonStyle(
          colors: colors,
          typography: typography,
          style: style,
          color: colors.destructive,
          foregroundColor: colors.background,
        ).copyWith(
          contentStyle: base.contentStyle
              .copyWith(
                textStyle: FWidgetStateMap<TextStyle>.all(
                  TextStyle(
                    fontSize: 16,
                    color: colors.destructiveForeground,
                    fontWeight: .w600,
                  ),
                ),
              )
              .call,
        ),
  );
}

FButtonStyle buttonStyle({
  required FColors colors,
  required FTypography typography,
  required FStyle style,
  required Color color,
  required Color foregroundColor,
  bool boldText = false,
}) => FButtonStyle(
  decoration: FWidgetStateMap({
    WidgetState.disabled: BoxDecoration(
      borderRadius: .circular(24),
      color: colors.disable(color),
    ),
    WidgetState.hovered | WidgetState.pressed: BoxDecoration(
      borderRadius: .circular(24),
      color: colors.hover(color),
    ),
    WidgetState.any: BoxDecoration(borderRadius: .circular(24), color: color),
  }),
  focusedOutlineStyle: style.focusedOutlineStyle,

  contentStyle:
      FButtonContentStyle.inherit(
        typography: typography,
        enabled: foregroundColor,
        disabled: colors.disable(foregroundColor, colors.disable(color)),
      ).copyWith(
        textStyle: FWidgetStateMap<TextStyle>.all(
          boldText
              ? const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
              : const TextStyle(fontSize: 16),
        ),
      ),

  iconContentStyle: FButtonIconContentStyle(
    iconStyle: FWidgetStateMap({
      WidgetState.disabled: IconThemeData(
        color: colors.disable(foregroundColor, colors.disable(color)),
        size: 20,
      ),
      WidgetState.any: IconThemeData(color: foregroundColor, size: 20),
    }),
  ),

  tappableStyle: style.tappableStyle,
);
