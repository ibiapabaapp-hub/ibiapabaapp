import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:ibiapabaapp/features/auth/presentation/providers/auth_state_provider.dart';

void showLogoutDialog(BuildContext context, WidgetRef ref) {
  final authState = ref.read(authStateProvider.notifier);
  final foruiTheme = context.theme;

  showFDialog(
    context: context,
    builder: (context, style, animation) => FTheme(
      data: foruiTheme,
      child: FDialog(
        style: style.call,
        animation: animation,
        title: const Text('Sair da conta'),
        body: const Text(
          'Tem certeza que deseja sair? Você precisará fazer login novamente.',
        ),
        actions: [
          FButton(
            style: FButtonStyle.destructive(),
            onPress: () async {
              await authState.logout();
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
