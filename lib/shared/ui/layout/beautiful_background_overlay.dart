import 'package:flutter/material.dart';

class BeautifulBackgroundOverlay extends StatelessWidget {
  final bool? childBelow;
  final AlignmentGeometry alignment;
  final Widget child;
  final double opacity;

  const BeautifulBackgroundOverlay({
    super.key,
    required this.child,
    this.opacity = 0.24,
    this.alignment = Alignment.center,
    this.childBelow = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        childBelow == true ? child : const SizedBox.shrink(),
        Positioned.fill(
          child: IgnorePointer(
            child: Transform.scale(
              scale: 1.2,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: const AssetImage(
                      "assets/images/blob-gradient-bg-min.png",
                    ),
                    fit: BoxFit.cover,
                    opacity: opacity,
                    alignment: alignment,
                  ),
                ),
                child: Container(color: Colors.transparent),
              ),
            ),
          ),
        ),
        childBelow == false ? child : const SizedBox.shrink(),
      ],
    );
  }
}
