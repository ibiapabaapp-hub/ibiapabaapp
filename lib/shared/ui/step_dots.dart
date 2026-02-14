import 'package:flutter/material.dart';

class StepDots extends StatelessWidget {
  final int current;
  final int total;

  const StepDots({super.key, required this.current, required this.total});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(total, (index) {
        final isActiveOrPast = index <= current;

        return AnimatedContainer(
          duration: Duration(milliseconds: 200),
          margin: EdgeInsets.symmetric(horizontal: 4),
          width: isActiveOrPast ? 10 : 6,
          height: isActiveOrPast ? 10 : 6,
          decoration: BoxDecoration(
            color: isActiveOrPast
                ? Colors.white
                : Colors.white.withAlpha((255 / 3).toInt()),
            shape: BoxShape.circle,
          ),
        );
      }),
    );
  }
}
