import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:ibivibe/shared/ui/maps/fallback_map_widget.dart';
import 'package:ibivibe/shared/ui/maps/app_map.dart';

class SheetActions extends StatelessWidget {
  final bool isLoadingLocation;
  final VoidCallback detectNearestCity;
  final String? currentCityName;
  final AppLatLng? currentPosition;
  final Future<void> Function(String cityName)? onCitySelected;

  const SheetActions({
    super.key,
    required this.isLoadingLocation,
    required this.detectNearestCity,
    this.currentCityName,
    this.currentPosition,
    this.onCitySelected,
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
            onPress: () => _showCitySelectionDialog(context),
            style: FButtonStyle.secondary(),
            child: const Text('Selecionar cidade'),
          ),
        ),
      ],
    );
  }

  void _showCitySelectionDialog(BuildContext context) {
    final theme = context.theme;

    showFDialog(
      context: context,
      builder: (context, style, animation) => FTheme(
        data: theme,
        child: _CitySelectionDialogContent(
          style: style,
          animation: animation,
          currentPosition: currentPosition,
          currentCityName: currentCityName,
          onCitySelected: onCitySelected,
        ),
      ),
    );
  }
}

class _CitySelectionDialogContent extends StatelessWidget {
  final FDialogStyle style;
  final Animation<double> animation;
  final AppLatLng? currentPosition;
  final String? currentCityName;
  final Future<void> Function(String cityName)? onCitySelected;

  const _CitySelectionDialogContent({
    required this.style,
    required this.animation,
    this.currentPosition,
    this.currentCityName,
    this.onCitySelected,
  });

  @override
  Widget build(BuildContext context) {
    return FDialog(
      style: style.call,
      animation: animation,
      direction: .horizontal,
      title: Row(
        children: [
          Icon(
            Icons.edit_location_outlined,
            size: 16,
            color: context.theme.colors.mutedForeground,
          ),
          const SizedBox(width: 6),
          const Text('Selecionar cidade'),
        ],
      ),
      body: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.3,
        ),
        child: FallbackMapWidget(
          initialPosition:
              currentPosition ?? const AppLatLng(-3.9248, -40.8868),
          initialZoom: 13.0,
          currentPosition: currentPosition,
          currentCityName: currentCityName,
          onCitySelected: (cityName) async {
            Navigator.of(context).pop();
            await onCitySelected?.call(cityName);
          },
        ),
      ),
      actions: const [],
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
