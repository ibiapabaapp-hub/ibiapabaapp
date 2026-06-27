import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:ibivibe/core/preferences/user_preferences_state_provider.dart';
import 'package:ibivibe/shared/ui/dialogs/clear_cache_dialog.dart';
import 'package:ibivibe/shared/ui/dialogs/logout_dialog.dart';
import 'package:ibivibe/shared/ui/dialogs/theme_dialog.dart';
import 'package:ibivibe/shared/utils/show_todo_toast.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: FScaffold(
        header: FHeader.nested(
          prefixes: [
            FButton.icon(
              style: FButtonStyle.ghost(),
              onPress: () => context.pop(),
              child: const Icon(Icons.arrow_back_rounded, size: 24),
            ),
          ],
          title: Text('Configurações', style: context.theme.typography.base),
        ),
        child: SingleChildScrollView(
          child: Column(
            spacing: 24,
            children: [
              _AccountSection(),
              _AppearenceSection(),
              _NotificationsSection(),
              _StorageSection(),
              _SocialSection(),
              _LogoutButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _AccountSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FTileGroup(
      label: Text('Conta', style: context.theme.typography.sm),
      divider: FItemDivider.full,
      children: [
        .tile(
          prefix: const Icon(FIcons.user),
          title: const Text('Perfil'),
          subtitle: const Text('Nome, foto, informações adicionais'),
          suffix: const Icon(FIcons.chevronRight),
          onPress: () => showTodoToast(context, 'Perfil'),
          // onPress: () => context.push('/onboarding'),
        ),
        .tile(
          prefix: const Icon(FIcons.creditCard),
          title: const Text('Pagamentos'),
          subtitle: const Text('Assinatura, métodos e histórico'),
          suffix: const Icon(FIcons.chevronRight),
          onPress: () => showTodoToast(context, 'Pagamentos'),
        ),
        .tile(
          prefix: const Icon(FIcons.lock),
          title: const Text('Segurança'),
          subtitle: const Text('Senha e autenticação'),
          suffix: const Icon(FIcons.chevronRight),
          onPress: () => showTodoToast(context, 'Segurança'),
        ),
      ],
    );
  }
}

class _AppearenceSection extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentThemeMode = ref.watch(
      userPreferencesStateProvider.select((s) => s.themeMode),
    );

    return FTileGroup(
      label: Text('Aparência', style: context.theme.typography.sm),
      divider: FItemDivider.full,
      children: [
        .tile(
          prefix: const Icon(FIcons.moon),
          title: const Text('Tema'),
          subtitle: Text(switch (currentThemeMode) {
            ThemeMode.light => 'Claro',
            ThemeMode.dark => 'Escuro',
            ThemeMode.system => 'Sistema',
          }),
          suffix: const Icon(FIcons.chevronRight),
          onPress: () => showThemeDialog(context, ref),
        ),
        .tile(
          prefix: const Icon(FIcons.globe),
          title: const Text('Idioma'),
          subtitle: const Text('Português (BR)'),
          suffix: const Icon(FIcons.chevronRight),
          onPress: () => showTodoToast(context, 'Idioma'),
        ),
      ],
    );
  }
}

class _NotificationsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FTileGroup(
      label: Text('Notificações', style: context.theme.typography.sm),
      divider: FItemDivider.full,
      children: [
        .tile(
          prefix: const Icon(FIcons.bell),
          title: const Text('Notificações push'),
          suffix: const FSwitch(),
          onPress: () => showTodoToast(context, 'Notificações push'),
        ),
        .tile(
          prefix: const Icon(FIcons.bell),
          title: const Text('Lembretes'),
          subtitle: const Text('Alertas e avisos'),
          suffix: const Icon(FIcons.chevronRight),
          onPress: () => showTodoToast(context, 'Notificações'),
        ),
      ],
    );
  }
}

class _StorageSection extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FTileGroup(
      label: Text('Armazenamento', style: context.theme.typography.sm),
      divider: FItemDivider.full,
      children: [
        .tile(
          prefix: const Icon(FIcons.trash),
          title: const Text('Limpar cache'),
          subtitle: const Text('Remover dados temporários'),
          onPress: () => showClearCacheDialog(context, ref),
        ),
      ],
    );
  }
}

class _SocialSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FTileGroup(
      divider: FItemDivider.full,
      label: Text('Social e Informações', style: context.theme.typography.sm),
      children: [
        .tile(
          prefix: const Icon(FIcons.share),
          title: const Text('Compartilhe com amigos'),
          suffix: const Icon(FIcons.chevronRight),
          onPress: () => showTodoToast(context, 'Compartilhar com amigos'),
        ),
        .tile(
          prefix: const Icon(FIcons.messageCircleQuestionMark),
          title: const Text('Ajuda e suporte'),
          subtitle: const Text('FAQ e contato'),
          suffix: const Icon(FIcons.chevronRight),
          onPress: () => showTodoToast(context, 'Ajuda e suporte'),
        ),
        .tile(
          prefix: const Icon(FIcons.info),
          title: const Text('Sobre o app'),
          subtitle: const Text('Versão 1.0.0'),
          suffix: const Icon(FIcons.chevronRight),
          onPress: () => showTodoToast(context, 'Sobre'),
        ),
        .tile(
          prefix: const Icon(FIcons.file),
          title: const Text('Termos de Serviço'),
          suffix: const Icon(FIcons.chevronRight),
          onPress: () => showTodoToast(context, 'Termos de serviço'),
        ),
        .tile(
          prefix: const Icon(FIcons.shield),
          title: const Text('Política de Privacidade'),
          suffix: const Icon(FIcons.chevronRight),
          onPress: () => showTodoToast(context, 'Política de privacidade'),
        ),
      ],
    );
  }
}

class _LogoutButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FTile(
      onPress: () => showLogoutDialog(context, ref),
      prefix: Icon(FIcons.logOut, color: context.theme.colors.destructive),
      title: Text(
        'Sair da conta',
        style: context.theme.typography.base.copyWith(
          fontWeight: FontWeight.w500,
          color: context.theme.colors.destructive,
        ),
      ),
    );
  }
}
