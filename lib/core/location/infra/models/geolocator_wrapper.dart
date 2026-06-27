import 'package:geolocator/geolocator.dart';

abstract interface class GeolocatorWrapper {
  Future<bool> isLocationServiceEnabled();
  Future<LocationPermission> checkPermission();
  Future<LocationPermission> requestPermission();
  Future<Position> getCurrentPosition({LocationSettings? locationSettings});
  Future<bool> openAppSettings();
}

class GeolocatorWrapperImpl implements GeolocatorWrapper {
  const GeolocatorWrapperImpl();

  @override
  Future<bool> isLocationServiceEnabled() =>
      Geolocator.isLocationServiceEnabled();

  @override
  Future<LocationPermission> checkPermission() => Geolocator.checkPermission();

  @override
  Future<LocationPermission> requestPermission() =>
      Geolocator.requestPermission();

  @override
  Future<Position> getCurrentPosition({LocationSettings? locationSettings}) =>
      Geolocator.getCurrentPosition(locationSettings: locationSettings);

  @override
  Future<bool> openAppSettings() => Geolocator.openAppSettings();
}
