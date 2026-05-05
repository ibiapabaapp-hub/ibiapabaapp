import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:ibiapabaapp/app/theme/flat_button_style.dart';
import 'package:ibiapabaapp/features/profiles/presentation/widgets/screens/under_development_screen.dart';
import 'package:ibiapabaapp/features/webviews/presentation/screens/webview_screen.dart';
import 'package:ibiapabaapp/shared/ui/layout/section_header.dart';
import 'package:ibiapabaapp/shared/ui/layout/unimplemented_wrapper.dart';

class PersonalProfileContent extends StatelessWidget {
  const PersonalProfileContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 16,
      children: [
        SectionHeader(
          title: 'Sua Atividade',
          seeAllText: 'Ajuda',
          onSeeAllTap: () => context.push(
            '/app/under-development-notice',
            extra: const UnderDevelopmentArgs(
              featureName: 'Sua Atividade',
              featureIcon: FIcons.chartBarIncreasing,
              featureDescription:
                  'Em breve você poderá acompanhar seu progresso na exploração '
                  'da Serra da Ibiapaba.',
            ),
          ),
        ),
        _InsightsSection(),

        const FDivider(),
        SectionHeader(
          title: 'Interações',
          seeAllText: 'Ajuda',
          onSeeAllTap: () => context.push(
            '/app/under-development-notice',
            extra: const UnderDevelopmentArgs(
              featureName: 'Interações',
              featureIcon: FIcons.messageSquare,
              featureDescription:
                  'Em breve você poderá acompanhar suas interações com o aplicativo.',
            ),
          ),
        ),
        _InteractionsSection(),

        const FDivider(),
        SectionHeader(
          title: 'Expedição Ibiapaba',
          seeAllText: 'Ajuda',
          onSeeAllTap: () => context.push('/app/under-development-notice'),
        ),
        _ExpeditionSection(),

        const FDivider(),
        SectionHeader(
          title: 'Configurações rápidas',
          seeAllText: 'Ajuda',
          onSeeAllTap: () => context.push('/app/under-development-notice'),
        ),
        _QuickSettingsSection(),

        const FDivider(),
        SectionHeader(
          title: 'Informações do Aplicativo',
          seeAllText: 'Ajuda',
          onSeeAllTap: () => context.push('/app/under-development-notice'),
        ),
        _AppInfoSection(),
      ],
    );
  }
}

class _InsightsSection extends StatelessWidget {
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

class _QuickSettingsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 20,
      children: [
        FButton(
          style: flatButtonStyle,
          onPress: () => context.push('/app/interests/businesses'),
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          prefix: const Icon(FIcons.userStar, size: 24),
          child: Text('Seus interesses', style: context.theme.typography.base),
        ),
        UnimplementedWrapper(
          child: FButton(
            style: flatButtonStyle,
            onPress: () {},
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            prefix: const Icon(FIcons.shieldCheck, size: 24),
            child: Text('Segurança', style: context.theme.typography.base),
          ),
        ),
        UnimplementedWrapper(
          child: FButton(
            style: flatButtonStyle,
            onPress: () {},
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            prefix: const Icon(FIcons.bell, size: 24),
            child: Text('Notificações', style: context.theme.typography.base),
          ),
        ),
        FButton(
          style: flatButtonStyle,
          onPress: () => context.push('/app/settings'),
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          prefix: const Icon(FIcons.settings, size: 24),
          child: Text(
            'Configurações do aplicativo',
            style: context.theme.typography.base,
          ),
        ),
      ],
    );
  }
}

class _InteractionsSection extends StatelessWidget {
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
        UnimplementedWrapper(
          child: FButton(
            style: flatButtonStyle,
            onPress: () {},
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            prefix: const Icon(FIcons.heart, size: 24),
            child: Text('Favoritos', style: context.theme.typography.base),
          ),
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
        UnimplementedWrapper(
          child: FButton(
            style: flatButtonStyle,
            onPress: () {},
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            prefix: const Icon(FIcons.ticket, size: 24),
            child: Text('Inscrições', style: context.theme.typography.base),
          ),
        ),
        UnimplementedWrapper(
          child: FButton(
            style: flatButtonStyle,
            onPress: () {},
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            prefix: const Icon(FIcons.messageCircleWarning, size: 24),
            child: Text('Denúncias', style: context.theme.typography.base),
          ),
        ),
      ],
    );
  }
}

class _ExpeditionSection extends StatelessWidget {
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
        UnimplementedWrapper(
          child: FButton(
            style: flatButtonStyle,
            onPress: () {},
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            prefix: const Icon(FIcons.target, size: 24),
            child: Text(
              'Desafios de temporada',
              style: context.theme.typography.base,
            ),
          ),
        ),
      ],
    );
  }
}

class _AppInfoSection extends StatelessWidget {
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
            prefix: const Icon(FIcons.circleQuestionMark, size: 24),
            child: Text(
              'Suporte e Ajuda',
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
            prefix: const Icon(FIcons.megaphone, size: 24),
            child: Text(
              'Reportar problema',
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
            prefix: const Icon(FIcons.star, size: 24),
            child: Text(
              'Avaliar experiência',
              style: context.theme.typography.base,
            ),
          ),
        ),
        FButton(
          style: flatButtonStyle,
          onPress: () {
            openWebView(
              context,
              title: 'Sobre',
              url: 'https://www.ibiapabaapp.com.br/',
            );
          },
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          prefix: const Icon(FIcons.info, size: 24),
          child: Text('Sobre', style: context.theme.typography.base),
        ),
      ],
    );
  }
}
