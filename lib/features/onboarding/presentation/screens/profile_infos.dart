import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class OnboardingProfileInfosScreen extends StatefulWidget {
  const OnboardingProfileInfosScreen({super.key});

  @override
  State<OnboardingProfileInfosScreen> createState() =>
      _OnboardingProfileScreenState();
}

class _OnboardingProfileScreenState
    extends State<OnboardingProfileInfosScreen> {
  @override
  Widget build(BuildContext context) {
    return const FScaffold(
      header: FHeader.nested(),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 32,
          children: [_Heading()],
        ),
      ),
    );
  }
}

class _Heading extends StatelessWidget {
  const _Heading();

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: [
        Text(
          'Identificação',
          style: theme.typography.xl2.copyWith(fontWeight: FontWeight.w600),
        ),
        Text(
          'Preencha informações básicas para identificar seu novo perfil',
          style: theme.typography.base,
        ),
      ],
    );
  }
}
