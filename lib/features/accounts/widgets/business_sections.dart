import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:ibivibe/app/theme/adapted_styles/flat_button_style.dart';
import 'package:ibivibe/features/webviews/screens/webview_screen.dart';
import 'package:ibivibe/shared/ui/layout/unimplemented_wrapper.dart';

class QuickSettingsSection extends StatelessWidget {
  const QuickSettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 20,
      children: [
        FButton(
          style: flatButtonStyle,
          onPress: () => context.push('/app/account/interests'),
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

class AppInfoSection extends StatelessWidget {
  const AppInfoSection({super.key});

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
        FButton(
          style: flatButtonStyle,
          onPress: () {
            openWebView(
              context,
              title: 'Sobre',
              url: 'https://www.ibivibe.com.br/',
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

class BusinessDataSection extends StatelessWidget {
  final dynamic account;
  const BusinessDataSection({super.key, required this.account});

  @override
  Widget build(BuildContext context) {
    return FCard(
      title: Text(account.displayName, style: context.theme.typography.base),
      subtitle: Text(account.business?.description ?? 'Sem descrição'),
    );
  }
}

class BusinessManagementSection extends StatelessWidget {
  const BusinessManagementSection({super.key});

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
            child: Text('Meus negócios', style: context.theme.typography.base),
          ),
        ),
        UnimplementedWrapper(
          child: FButton(
            style: flatButtonStyle,
            onPress: () {},
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            prefix: const Icon(FIcons.calendar, size: 24),
            child: Text('Meus eventos', style: context.theme.typography.base),
          ),
        ),
        UnimplementedWrapper(
          child: FButton(
            style: flatButtonStyle,
            onPress: () {},
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            prefix: const Icon(FIcons.users, size: 24),
            child: Text('Colaboradores', style: context.theme.typography.base),
          ),
        ),
      ],
    );
  }
}

class DashboardSection extends StatelessWidget {
  const DashboardSection({super.key});

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

class ManagementSection extends StatelessWidget {
  const ManagementSection({super.key});

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
