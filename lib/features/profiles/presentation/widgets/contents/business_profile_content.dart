import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:ibiapabaapp/app/theme/flat_button_style.dart';
import 'package:ibiapabaapp/shared/ui/layout/section_header.dart';
import 'package:ibiapabaapp/shared/ui/layout/unimplemented_wrapper.dart';

class BusinessProfileContent extends StatelessWidget {
  const BusinessProfileContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 16,
      children: [
        SectionHeader(
          title: 'Dashboard da Empresa',
          seeAllText: 'Ajuda',
          onSeeAllTap: () => context.push('/app/under-development-notice'),
        ),
        _DashboardSection(),

        const FDivider(),
        SectionHeader(
          title: 'Gestão da Unidade',
          seeAllText: 'Ajuda',
          onSeeAllTap: () => context.push('/app/under-development-notice'),
        ),
        _ManagementSection(),

        const FDivider(),
        SectionHeader(
          title: 'Definições rápidas',
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

class _DashboardSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return UnimplementedWrapper(
      child: FCard(
        title: Text(
          'Performance Semanal',
          style: context.theme.typography.base,
        ),
        subtitle: Text(
          'Em breve você poderá ver o desempenho da sua empresa aqui.',
          style: context.theme.typography.sm.copyWith(
            fontWeight: FontWeight.w400,
            color: context.theme.colors.mutedForeground,
          ),
        ),
      ),
    );
  }
}

class _ManagementSection extends StatelessWidget {
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
            prefix: const Icon(FIcons.store, size: 24),
            child: Text(
              'Dados da Empresa',
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
            prefix: const Icon(FIcons.clock, size: 24),
            child: Text(
              'Horários de Funcionamento',
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
            prefix: const Icon(FIcons.users, size: 24),
            child: Text(
              'Membros da Equipe',
              style: context.theme.typography.base,
            ),
          ),
        ),
      ],
    );
  }
}

class _QuickSettingsSection extends StatelessWidget {
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
        UnimplementedWrapper(
          child: FButton(
            style: flatButtonStyle,
            onPress: () {},
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            prefix: const Icon(FIcons.info, size: 24),
            child: Text('Sobre', style: context.theme.typography.base),
          ),
        ),
      ],
    );
  }
}
