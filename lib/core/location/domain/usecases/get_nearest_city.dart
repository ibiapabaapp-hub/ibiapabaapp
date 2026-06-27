import 'package:ibivibe/core/errors/failures/failures.dart';
import 'package:ibivibe/core/location/infra/location_service.dart';
import 'package:ibivibe/shared/models/city.dart';
import 'package:latlong2/latlong.dart';

import '../exceptions/location_exceptions.dart';

class GetNearestCity {
  GetNearestCity({required this.locationService});

  final LocationService locationService;
  final _distance = const Distance();

  Future<City> call(List<City> cities) async {
    if (cities.isEmpty) {
      throw const LocationUnknownFailure('Nenhuma cidade disponível.');
    }

    final LatLng userLocation;
    try {
      userLocation = await locationService.getCurrentLocation();
    } on LocationException catch (e) {
      throw _mapExceptionToFailure(e);
    }

    final citiesWithLocation = cities.where((c) => c.location != null).toList();
    if (citiesWithLocation.isEmpty) {
      throw const LocationUnknownFailure(
        'Nenhuma cidade possui coordenadas cadastradas.',
      );
    }

    City nearest = citiesWithLocation.first;
    double minDistance = _distance.as(
      LengthUnit.Kilometer,
      userLocation,
      nearest.location!,
    );

    for (final city in citiesWithLocation.skip(1)) {
      final d = _distance.as(
        LengthUnit.Kilometer,
        userLocation,
        city.location!,
      );
      if (d < minDistance) {
        minDistance = d;
        nearest = city;
      }
    }

    return nearest;
  }

  AppFailure _mapExceptionToFailure(LocationException e) => switch (e) {
    LocationPermissionDeniedException() =>
      const LocationPermissionDeniedFailure(),
    LocationPermissionPermanentlyDeniedException() =>
      const LocationPermissionPermanentlyDeniedFailure(),
    LocationDisabledException() => const LocationDisabledFailure(),
    LocationTimeoutException() => const LocationTimeoutFailure(),
    LocationUnknownException() => LocationUnknownFailure(e.message),
  };
}
