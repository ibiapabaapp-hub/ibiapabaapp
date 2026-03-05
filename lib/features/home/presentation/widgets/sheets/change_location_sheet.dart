import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Import necessário
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:ibiapabaapp/features/auth/presentation/providers/session_provider.dart';
import 'package:ibiapabaapp/shared/ui/layout/sheet_drag_indicator.dart';

void showChangeLocationSheet({required BuildContext context}) {
  showModalBottomSheet(
    useRootNavigator: true,
    isScrollControlled: true,
    context: context,
    barrierColor: Colors.black45,
    isDismissible: true,
    builder: (context) => Consumer(
      builder: (context, ref, child) {
        final theme = context.theme;

        return SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.72,
            decoration: BoxDecoration(
              color: theme.colors.background,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(24),
              ),
            ),

            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SheetDragIndicator(),
                  const SizedBox(height: 24),
                  Text(
                    'Alternar cidade atual',
                    style: theme.typography.lg.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  FButton(
                    onPress: () async {
                      context.pop();
                      await ref.read(sessionProvider.notifier).logout();
                    },
                    style: FButtonStyle.destructive(),
                    prefix: Icon(Icons.logout),
                    child: const Text('Sair da conta'),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}
