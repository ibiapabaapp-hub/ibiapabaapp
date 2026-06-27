import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:ibivibe/core/location/domain/exceptions/location_exceptions.dart';
import 'package:ibivibe/core/location/infra/models/geolocator_wrapper.dart';
import 'package:latlong2/latlong.dart';

class LocationService {
  LocationService({GeolocatorWrapper? geolocator})
    : _geolocator = geolocator ?? const GeolocatorWrapperImpl();

  final GeolocatorWrapper _geolocator;

  Future<LatLng> getCurrentLocation() async {
    try {
      final enabled = await _geolocator.isLocationServiceEnabled();
      if (!enabled) throw const LocationDisabledException();
    } catch (e) {
      if (e is LocationDisabledException) rethrow;
      throw const LocationDisabledException();
    }

    var permission = await _geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await _geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw const LocationPermissionDeniedException();
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw const LocationPermissionPermanentlyDeniedException();
    }

    try {
      final position = await _geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 10),
        ),
      );
      return LatLng(position.latitude, position.longitude);
    } on TimeoutException {
      throw const LocationTimeoutException();
    } catch (e) {
      throw LocationUnknownException(e.toString());
    }
  }

  Future<bool> openAppSettings() => _geolocator.openAppSettings();
}
