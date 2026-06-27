import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ibivibe/core/preferences/user_preferences_state_provider.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

import 'app_map.dart';

class MapLibreMapWidget extends AppMapWidget {
  const MapLibreMapWidget({
    super.key,
    required super.initialPosition,
    required super.initialZoom,
    super.currentPosition,
    super.interactive,
  });

  @override
  ConsumerState<MapLibreMapWidget> createState() => _MapLibreMapWidgetState();
}

class _MapLibreMapWidgetState extends ConsumerState<MapLibreMapWidget> {
  final Completer<MapLibreMapController> _controllerCompleter =
      Completer<MapLibreMapController>();

  bool _styleLoaded = false;
  Circle? _currentCircle;

  // ── helpers ────────────────────────────────────────────────────────────────

  LatLng _toLatLng(AppLatLng p) => LatLng(p.latitude, p.longitude);

  CameraPosition get _initialCameraPosition => CameraPosition(
    target: _toLatLng(widget.initialPosition),
    zoom: widget.initialZoom,
  );

  // ── lifecycle ──────────────────────────────────────────────────────────────

  @override
  void didUpdateWidget(MapLibreMapWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    final pos = widget.currentPosition;
    if (pos != null && pos != oldWidget.currentPosition) {
      _updateMarkerAndCamera(pos);
    }
  }

  @override
  void dispose() {
    _controllerCompleter.future.then((c) => c.dispose(), onError: (_) {});
    super.dispose();
  }

  // ── mapa ───────────────────────────────────────────────────────────────────

  Future<void> _updateMarkerAndCamera(AppLatLng pos) async {
    if (!_styleLoaded) return;

    final controller = await _controllerCompleter.future;
    final latLng = _toLatLng(pos);

    if (_currentCircle != null) {
      await controller.removeCircle(_currentCircle!);
    }

    _currentCircle = await controller.addCircle(
      CircleOptions(
        geometry: latLng,
        circleRadius: 8,
        circleColor: '#007AFF',
        circleStrokeColor: '#FFFFFF',
        circleStrokeWidth: 2,
        circleOpacity: 0.9,
      ),
    );

    await controller.animateCamera(CameraUpdate.newLatLng(latLng));
  }

  // ── callbacks ──────────────────────────────────────────────────────────────

  void _onMapCreated(MapLibreMapController controller) {
    _controllerCompleter.complete(controller);
  }

  void _onStyleLoaded() {
    setState(() => _styleLoaded = true);
    final pos = widget.currentPosition;
    if (pos != null) {
      _updateMarkerAndCamera(pos);
    }
  }

  // ── build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    ThemeMode themeMode = ref.watch(userPreferencesStateProvider).themeMode;
    final interactive = widget.interactive;

    final brightness = themeMode == ThemeMode.system
        ? MediaQuery.platformBrightnessOf(context)
        : themeMode == ThemeMode.dark
        ? Brightness.dark
        : Brightness.light;

    final isDark = brightness == Brightness.dark;
    final styleString = isDark
        ? 'https://tiles.openfreemap.org/styles/dark'
        : 'https://tiles.openfreemap.org/styles/bright';

    return MapLibreMap(
      key: ValueKey(styleString),
      styleString: styleString,
      attributionButtonPosition: .topRight,
      initialCameraPosition: _initialCameraPosition,
      onMapCreated: _onMapCreated,
      onStyleLoadedCallback: _onStyleLoaded,
      scrollGesturesEnabled: interactive,
      zoomGesturesEnabled: interactive,
      rotateGesturesEnabled: false,
      tiltGesturesEnabled: false,
      myLocationEnabled: false,
      trackCameraPosition: interactive,
      compassEnabled: interactive,
      dragEnabled: interactive,
    );
  }
}
