import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:forui/forui.dart';

void showExitAppDialog(BuildContext context) {
  showCupertinoDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return FDialog(
        title: const Text('Sair do aplicativo'),
        body: const Text('Tem certeza que deseja sair?'),
        actions: [
          FButton(
            style: FButtonStyle.secondary(),
            onPress: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancelar'),
          ),
          FButton(
            style: FButtonStyle.destructive(),
            onPress: () {
              exit(0);
            },
            child: const Text('Sair'),
          ),
        ],
      );
    },
  );
}
