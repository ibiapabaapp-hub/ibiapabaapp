import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:ibiapabaapp/core/cache/cache_database_provider.dart';
import 'package:ibiapabaapp/shared/ui/fragments/toast/show_app_toast.dart';

void showClearCacheDialog(BuildContext context, WidgetRef ref) {
  final foruiTheme = context.theme;

  showFDialog(
    context: context,
    builder: (context, style, animation) => FTheme(
      data: foruiTheme,
      child: FDialog(
        style: style.call,
        animation: animation,
        title: const Text('Limpar cache'),
        body: const Text(
          'Tem certeza que deseja limpar o cache? Isso irá remover buscas recentes e dados de localização.',
        ),
        actions: [
          FButton(
            style: FButtonStyle.destructive(),
            onPress: () async {
              await ref.read(clearUnnecessaryCacheProvider.future);
              if (context.mounted) {
                context.pop();
                showAppToast(
                  context: context,
                  title: 'Cache limpo com sucesso',
                  icon: const Icon(Icons.check),
                );
              }
            },
            child: const Text('Limpar'),
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
