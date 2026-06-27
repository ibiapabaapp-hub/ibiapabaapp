import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppLatLng {
  const AppLatLng(this.latitude, this.longitude);

  final double latitude;
  final double longitude;
}

abstract class AppMapWidget extends ConsumerStatefulWidget {
  final AppLatLng initialPosition;
  final double initialZoom;
  final AppLatLng? currentPosition;
  final Future<void> Function(String cityName)? onCitySelected;
  final String? currentCityName;
  final bool interactive;

  const AppMapWidget({
    super.key,
    required this.initialPosition,
    required this.initialZoom,
    this.currentPosition,
    this.onCitySelected,
    this.currentCityName,
    this.interactive = false,
  });
}
