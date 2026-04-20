import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:ibiapabaapp/core/preferences/user_preferences_state_provider.dart';

void showThemeDialog(BuildContext context, WidgetRef ref) {
  final current = ref.read(
    userPreferencesStateProvider.select((s) => s.themeMode),
  );
  final prefs = ref.read(userPreferencesStateProvider.notifier);
  final foruiTheme = context.theme;

  showFDialog(
    context: context,
    builder: (context, style, animation) => FTheme(
      data: foruiTheme,
      child: _ThemeDialogContent(
        style: style,
        animation: animation,
        current: current,
        prefs: prefs,
      ),
    ),
  );
}

class _ThemeDialogContent extends ConsumerStatefulWidget {
  final FDialogStyle style;
  final Animation<double> animation;
  final ThemeMode current;
  final UserPreferencesState prefs;

  const _ThemeDialogContent({
    required this.style,
    required this.animation,
    required this.current,
    required this.prefs,
  });

  @override
  ConsumerState<_ThemeDialogContent> createState() =>
      _ThemeDialogContentState();
}

class _ThemeDialogContentState extends ConsumerState<_ThemeDialogContent> {
  late ThemeMode _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.current;
  }

  @override
  Widget build(BuildContext context) {
    return FDialog(
      style: widget.style.call,
      animation: widget.animation,
      direction: .horizontal,
      title: const Text('Tema'),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          const SizedBox(height: 4),
          for (final option in [
            ThemeMode.light,
            ThemeMode.dark,
            ThemeMode.system,
          ])
            FRadio(
              value: _selected == option,
              label: Text(switch (option) {
                ThemeMode.light => 'Claro',
                ThemeMode.dark => 'Escuro',
                ThemeMode.system => 'Sistema',
              }, style: context.theme.typography.sm),
              onChange: (_) async {
                setState(() => _selected = option);
                await widget.prefs.setFavoriteThemeMode(option);
                if (context.mounted) context.pop();
              },
            ),
        ],
      ),
      actions: [
        FButton(
          style: FButtonStyle.ghost(),
          onPress: () => (context).pop(),
          child: const Text('Cancelar'),
        ),
      ],
    );
  }
}
