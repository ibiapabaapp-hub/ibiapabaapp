import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:ibiapabaapp/features/welcome/widgets/welcome_carousel.dart';
import 'package:ibiapabaapp/shared/ui/layout/beautiful_background_overlay.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      childPad: false,
      child: BeautifulBackgroundOverlay(
        child: Column(
          mainAxisAlignment: .center,
          spacing: 24,
          children: [
            const WelcomeCarousel(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                spacing: 16,
                children: [
                  Column(
                    spacing: 16,
                    children: [
                      FButton(
                        onPress: () => context.push('/auth/register'),
                        child: const Text("Criar conta"),
                      ),
                      FButton(
                        onPress: () => context.push('/auth/login'),
                        style: FButtonStyle.ghost(),
                        child: const Text("Entrar"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
