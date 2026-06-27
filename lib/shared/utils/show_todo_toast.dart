import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:ibivibe/shared/ui/fragments/toast/show_app_toast.dart';

void showTodoToast(BuildContext context, String page) {
  // TODO: implementar a funcionalidade real de cada redirect
  showAppToast(
    context: context,
    icon: const Icon(FIcons.bicepsFlexed),
    title: 'TODO',
    description: 'redirecionar para $page',
  );
}
