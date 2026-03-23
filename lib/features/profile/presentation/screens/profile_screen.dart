import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:ibiapabaapp/core/session/app_session_notifier_provider.dart';
import 'package:ibiapabaapp/features/auth/domain/entities/user.dart';
import 'package:ibiapabaapp/shared/ui/fragments/toast/show_app_toast.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(appSessionProvider.select((s) => s.user));
    return SafeArea(
      top: true,
      child: FScaffold(
        header: FHeader.nested(
          suffixes: [
            FButton.icon(
              style: FButtonStyle.ghost(),
              onPress: () {
                context.push('/app/settings');
              },
              child: Icon(FIcons.settings),
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
            child: Column(spacing: 24, children: [_ProfileWidget(user: user)]),
          ),
        ),
      ),
    );
  }
}

void showTodoToast(BuildContext context, String page) {
  // TODO: implementar a funcionalidade real de cada redirect
  showAppToast(
    context: context,
    title: Text(
      'TODO: redirecionar para $page',
      style: context.theme.typography.sm.copyWith(
        color: context.theme.colors.foreground,
      ),
    ),
  );
}

class _ProfileWidget extends StatelessWidget {
  final User? user;

  const _ProfileWidget({required this.user});

  // TODO: troca de perfil
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12,
      children: [
        _ProfilePhoto(),
        Column(
          mainAxisSize: .min,
          mainAxisAlignment: .center,
          crossAxisAlignment: .center,
          spacing: 8,
          children: [
            Text(
              user?.name ?? 'ET Bilu',
              textAlign: .center,
              overflow: .ellipsis,
              style: TextStyle(
                color: context.theme.colors.foreground,
                fontSize: 18,
                fontWeight: .w500,
              ),
            ),
            Text(
              '@${user?.username ?? 'et_bilu'}',
              textAlign: .center,
              overflow: .ellipsis,
              style: TextStyle(
                color: context.theme.colors.mutedForeground,
                fontSize: 16,
                fontWeight: .w400,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ProfilePhoto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      height: 64,
      decoration: ShapeDecoration(
        color: context.theme.colors.secondary,
        shape: RoundedRectangleBorder(borderRadius: .circular(50)),
      ),
    );
  }
}
