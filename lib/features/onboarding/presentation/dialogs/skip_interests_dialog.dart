import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

void showSkipInterestsDialog({
  required BuildContext context,
  required VoidCallback onConfirm,
}) {
  final foruiTheme = context.theme;

  showFDialog(
    context: context,
    builder: (context, style, animation) => FTheme(
      data: foruiTheme,
      child: FDialog(
        style: style.call,
        animation: animation,
        title: const Text('Pular interesses?'),
        body: const Text(
          'Se você pular, não poderemos recomendar empresas e eventos baseados no que você gosta.',
        ),
        actions: [
          FButton(
            style: FButtonStyle.destructive(),
            onPress: () {
              context.pop();
              onConfirm();
            },
            child: const Text('Pular mesmo assim'),
          ),
          FButton(
            style: FButtonStyle.outline(),
            onPress: () => context.pop(),
            child: const Text('Voltar'),
          ),
        ],
      ),
    ),
  );
}
