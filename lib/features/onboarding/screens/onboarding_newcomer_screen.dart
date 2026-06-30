import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

class OnboardingNewcomerScreen extends StatelessWidget {
  const OnboardingNewcomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return FScaffold(
      footer: Padding(
        padding: const EdgeInsetsGeometry.fromLTRB(16, 16, 16, 32),
        child: FButton(
          onPress: () => context.go('/onboarding/profile-select'),
          suffix: const Icon(FIcons.arrowRight),
          child: const Text('Continuar'),
        ),
      ),
      child: Column(
        spacing: 12,
        mainAxisAlignment: .center,
        children: [
          SvgPicture.asset(
            'assets/images/journey-amico-storyset.svg',
            height: 240,
          ),
          const SizedBox(height: 4),
          Text(
            'O que você está procurando?',
            style: theme.typography.xl.copyWith(fontWeight: .w800),
          ),
          Text(
            'Queremos descobrir seu intuito no app - para fazer recomendações certeiras ou divulgar seu negócio.',
            style: theme.typography.sm,
            textAlign: .center,
          ),
          Text(
            'Para isso separamos por perfil de interesse, vamos criar seu primeiro.',
            style: theme.typography.sm,
            textAlign: .center,
          ),
        ],
      ),
    );
  }
}
