import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class StepDots extends StatelessWidget {
  final int current;
  final int total;

  const StepDots({super.key, required this.current, required this.total});

  @override
  Widget build(BuildContext context) {
    return AnimatedSmoothIndicator(
      activeIndex: current,
      count: total,
      effect: ColorTransitionEffect(
        dotHeight: 8,
        dotWidth: 8,
        spacing: 8,
        dotColor: context.theme.colors.mutedForeground,
        activeDotColor: context.theme.colors.foreground,
      ),
    );
  }
}
