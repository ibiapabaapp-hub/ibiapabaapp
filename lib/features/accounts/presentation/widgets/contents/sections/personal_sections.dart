import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:ibivibe/app/theme/adapted_styles/flat_button_style.dart';
import 'package:ibivibe/shared/ui/layout/unimplemented_wrapper.dart';

class InsightsSection extends StatelessWidget {
  const InsightsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return UnimplementedWrapper(
      child: FCard(
        title: Text('Insights', style: context.theme.typography.base),
        subtitle: const Text(
          'Em breve você poderá ver seu progresso na exploração da Ibiapaba aqui.',
        ),
      ),
    );
  }
}

class InterestsSection extends StatelessWidget {
  const InterestsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return UnimplementedWrapper(
      child: FCard(
        title: Text('Seus interesses', style: context.theme.typography.base),
        subtitle: const Text(
          'Personalize sua experiência selecionando categorias de eventos e comércios que você mais gosta.',
        ),
      ),
    );
  }
}

class InteractionsSection extends StatelessWidget {
  const InteractionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 20,
      children: [
        UnimplementedWrapper(
          child: FButton(
            style: flatButtonStyle,
            onPress: () {},
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            prefix: const Icon(FIcons.calendar, size: 24),
            child: Text(
              'Agenda de eventos',
              style: context.theme.typography.base,
            ),
          ),
        ),
        UnimplementedWrapper(
          child: FButton(
            style: flatButtonStyle,
            onPress: () {},
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            prefix: const Icon(FIcons.map, size: 24),
            child: Text('Roteiros', style: context.theme.typography.base),
          ),
        ),
        FButton(
          style: flatButtonStyle,
          onPress: () => context.push('/app/favorites'),
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          prefix: const Icon(FIcons.heart, size: 24),
          child: Text('Favoritos', style: context.theme.typography.base),
        ),
        UnimplementedWrapper(
          child: FButton(
            style: flatButtonStyle,
            onPress: () {},
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            prefix: const Icon(FIcons.messageSquare, size: 24),
            child: Text('Avaliações', style: context.theme.typography.base),
          ),
        ),
      ],
    );
  }
}

class ExpeditionSection extends StatelessWidget {
  const ExpeditionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 20,
      children: [
        UnimplementedWrapper(
          child: FButton(
            style: flatButtonStyle,
            onPress: () {},
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            prefix: const Icon(FIcons.trophy, size: 24),
            child: Text('Conquistas', style: context.theme.typography.base),
          ),
        ),
        UnimplementedWrapper(
          child: FButton(
            style: flatButtonStyle,
            onPress: () {},
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            prefix: const Icon(FIcons.mountain, size: 24),
            child: Text(
              'Ranking de Altitude',
              style: context.theme.typography.base,
            ),
          ),
        ),
      ],
    );
  }
}
