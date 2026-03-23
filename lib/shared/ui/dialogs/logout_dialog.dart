import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:ibiapabaapp/core/session/app_session_notifier_provider.dart';

void showLogoutDialog(BuildContext context, WidgetRef ref) {
  final session = ref.read(appSessionProvider.notifier);
  final foruiTheme = context.theme;

  showFDialog(
    context: context,
    builder: (context, style, animation) => FTheme(
      data: foruiTheme,
      child: FDialog(
        style: style.call,
        animation: animation,
        title: const Text('Sair da conta'),
        body: Text(
          'Tem certeza que deseja sair? Você precisará fazer login novamente.',
        ),
        actions: [
          FButton(
            style: FButtonStyle.destructive(),
            onPress: () async {
              await session.logout();
              if (context.mounted) context.pop();
            },
            child: const Text('Sair'),
          ),
          FButton(
            style: FButtonStyle.outline(),
            onPress: () => context.pop(),
            child: const Text('Cancelar'),
          ),
        ],
      ),
    ),
  );
}
