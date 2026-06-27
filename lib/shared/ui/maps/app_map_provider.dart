import 'package:flutter/foundation.dart';
import 'package:ibiapabaapp/shared/ui/maps/app_map.dart';
import 'package:ibiapabaapp/shared/ui/maps/fallback_map_widget.dart';
import 'package:ibiapabaapp/shared/ui/maps/maplibre_map_widget.dart';

class AppMapProvider {
  AppMapProvider._();

  static bool get _mapLibreSupported =>
      defaultTargetPlatform == TargetPlatform.android ||
      defaultTargetPlatform == TargetPlatform.iOS ||
      kIsWeb;

  static AppMapWidget _build({
    required AppLatLng initialPosition,
    required double initialZoom,
    AppLatLng? currentPosition,
    Future<void> Function(String)? onCitySelected,
    String? currentCityName,
    Key? key,
    bool interactive = false,
  }) {
    if (_mapLibreSupported) {
      return MapLibreMapWidget(
        key: key,
        initialPosition: initialPosition,
        initialZoom: initialZoom,
        currentPosition: currentPosition,
        interactive: interactive,
      );
    }

    return FallbackMapWidget(
      key: key,
      initialPosition: initialPosition,
      initialZoom: initialZoom,
      currentPosition: currentPosition,
      onCitySelected: onCitySelected,
      currentCityName: currentCityName,
    );
  }

  static AppMapWidget create({
    required AppLatLng initialPosition,
    required double initialZoom,
    AppLatLng? currentPosition,
    Future<void> Function(String)? onCitySelected,
    String? currentCityName,
  }) => _build(
    initialPosition: initialPosition,
    initialZoom: initialZoom,
    currentPosition: currentPosition,
    onCitySelected: onCitySelected,
    currentCityName: currentCityName,
  );

  static AppMapWidget updatePosition(
    AppMapWidget current,
    AppLatLng? currentPosition,
  ) {
    if (current.currentPosition == currentPosition) return current;
    return _build(
      key: current.key,
      initialPosition: current.initialPosition,
      initialZoom: current.initialZoom,
      currentPosition: currentPosition,
      onCitySelected: current.onCitySelected,
      currentCityName: current.currentCityName,
    );
  }

  static AppMapWidget asInteractive(AppMapWidget current) {
    return _build(
      key: current.key,
      initialPosition: current.initialPosition,
      initialZoom: current.initialZoom,
      currentPosition: current.currentPosition,
      onCitySelected: current.onCitySelected,
      currentCityName: current.currentCityName,
      interactive: true,
    );
  }
}
