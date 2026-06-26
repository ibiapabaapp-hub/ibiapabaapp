import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:ibiapabaapp/app/theme/adapted_styles/flat_button_style.dart';
import 'package:ibiapabaapp/features/webviews/presentation/screens/webview_screen.dart';
import 'package:ibiapabaapp/shared/ui/layout/unimplemented_wrapper.dart';

class QuickSettingsSection extends StatelessWidget {
  const QuickSettingsSection({super.key});

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
