import 'dart:ui';
import 'package:flutter/material.dart';

class UnimplementedWrapper extends StatelessWidget {
  final Widget child;
  final bool isUnimplemented;
  final double opacity;
  final double blur;

  const UnimplementedWrapper({
    super.key,
    required this.child,
    this.isUnimplemented = true,
    this.opacity = 0.32,
    this.blur = 0.5,
  });

  @override
  Widget build(BuildContext context) {
    if (!isUnimplemented) {
      return child;
    }

    return AbsorbPointer(
      child: ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Opacity(opacity: opacity, child: child),
      ),
    );
  }
}
