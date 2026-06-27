import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

FDateFieldStyle dateFieldStyle({
  required FColors colors,
  required FTypography typography,
  required FStyle style,
}) => FDateFieldStyle(
  textFieldStyle: .inherit(colors: colors, typography: typography, style: style)
      .copyWith(
        contentTextStyle: FWidgetStateMap.all(
          TextStyle(fontSize: 14, color: colors.foreground),
        ),
      ),
  popoverStyle: .inherit(colors: colors, style: style),
  calendarStyle: .inherit(colors: colors, typography: typography, style: style)
      .copyWith(
        headerStyle: (style) => style.copyWith(
          headerTextStyle: const TextStyle(fontSize: 16, fontWeight: .w600),
        ),
      ),
  iconStyle: IconThemeData(color: colors.mutedForeground, size: 18),
);
