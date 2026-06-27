import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

final flatButtonStyle = FButtonStyle.ghost(
  (style) => style.copyWith(
    contentStyle: (style) =>
        style.copyWith(padding: const EdgeInsets.symmetric(vertical: 8)),
  ),
);
