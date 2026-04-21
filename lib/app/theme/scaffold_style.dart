import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

FScaffoldStyle scaffoldStyle({
  required FColors colors,
  required FStyle style,
}) => FScaffoldStyle(
  systemOverlayStyle: colors.systemOverlayStyle,
  backgroundColor: colors.background,
  sidebarBackgroundColor: colors.background,
  childPadding: style.pagePadding.copyWith(
    top: 16,
    bottom: 16,
    left: 16,
    right: 16,
  ),
  footerDecoration: BoxDecoration(
    border: Border(
      top: BorderSide(color: colors.border, width: style.borderWidth),
    ),
  ),
  headerDecoration: const BoxDecoration(),
);
