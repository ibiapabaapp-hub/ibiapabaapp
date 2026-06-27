import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class TappableContainer extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final BorderRadius borderRadius;
  final Color color;

  const TappableContainer({
    super.key,
    required this.child,
    required this.borderRadius,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return FTappable(
      onPress: onTap,
      child: Container(
        decoration: BoxDecoration(color: color, borderRadius: borderRadius),
        child: child,
      ),
    );
  }
}
