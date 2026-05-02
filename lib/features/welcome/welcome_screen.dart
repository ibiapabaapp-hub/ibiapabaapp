import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:ibiapabaapp/features/welcome/widgets/welcome_actions.dart';
import 'package:ibiapabaapp/features/welcome/widgets/welcome_carousel.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FScaffold(
        childPad: false,
        child: Column(
          mainAxisAlignment: .center,
          spacing: 24,
          children: [
            WelcomeCarousel(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: WelcomeActions(),
            ),
          ],
        ),
      ),
    );
  }
}
