import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

void redirectToUnderDevelopment(BuildContext context, String feature) {
  context.push(
    '/app/beta/under-development',
    extra: UnderDevelopmentArgs(featureName: feature),
  );
}

class UnderDevelopmentArgs {
  const UnderDevelopmentArgs({
    required this.featureName,
    this.featureDescription,
    this.featureIcon,
  });

  final String featureName;
  final String? featureDescription;
  final IconData? featureIcon;
}

class UnderDevelopmentScreen extends StatelessWidget {
  const UnderDevelopmentScreen({
    super.key,
    this.featureName,
    this.featureDescription,
    this.featureIcon,
  });

  final String? featureName;
  final String? featureDescription;
  final IconData? featureIcon;

  @override
  Widget build(BuildContext context) {
    final description =
        featureDescription ??
        'Em breve você poderá explorar ${featureName ?? 'tudo com liberdade'}. '
            'Nossa equipe está trabalhando para trazer essa experiência nova para você.';

    return FScaffold(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                featureIcon ?? FIcons.hammer,
                size: 64,
                color: context.theme.colors.primary,
              ),
              const SizedBox(height: 32),
              Text(
                '${featureName ?? 'App pronto'} em breve!',
                textAlign: TextAlign.center,
                style: context.theme.typography.lg.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                description,
                textAlign: TextAlign.center,
                style: context.theme.typography.sm.copyWith(
                  color: context.theme.colors.mutedForeground,
                ),
              ),
              const SizedBox(height: 32),
              FButton(
                onPress: () => context.pop(),
                child: const Text('Voltar'),
              ),
              const SizedBox(height: 16),
              Text(
                dotenv.env['APP_VERSION_TAG']!,
                style: context.theme.typography.sm.copyWith(
                  color: context.theme.colors.mutedForeground,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
