import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

FItemStyle fSelectItemStyle(BuildContext context, FItemStyle style) {
  return style.copyWith(
    contentStyle: (style) => style.copyWith(
      titleTextStyle: FWidgetStateMap.all(
        TextStyle(color: context.theme.colors.foreground),
      ),
    ),
  );
}
