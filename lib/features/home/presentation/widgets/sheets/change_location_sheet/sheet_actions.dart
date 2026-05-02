import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class SheetActions extends StatelessWidget {
  final bool isLoadingLocation;
  final VoidCallback detectNearestCity;

  const SheetActions({
    super.key,
    required this.isLoadingLocation,
    required this.detectNearestCity,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: FButton(
            onPress: isLoadingLocation ? null : detectNearestCity,
            style: FButtonStyle.primary(),
            child: Text(isLoadingLocation ? 'Localizando...' : 'Me localize'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: FButton(
            onPress: () {},
            style: FButtonStyle.secondary(),
            child: const Text(
              'Editar',
            ), // TODO: implementar seleção manual de cidade atual
          ),
        ),
      ],
    );
  }
}

class SheetActionsUnsupported extends StatelessWidget {
  const SheetActionsUnsupported({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Row(
      spacing: 6,
      children: [
        Icon(
          Icons.location_off_outlined,
          size: 16,
          color: theme.colors.mutedForeground,
        ),
        Expanded(
          child: Text(
            'Detecção automática indisponível nesta plataforma',
            style: theme.typography.sm.copyWith(
              color: theme.colors.mutedForeground,
            ),
          ),
        ),
      ],
    );
  }
}
