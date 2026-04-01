import 'package:dartz/dartz.dart';
import 'package:ibiapabaapp/core/location/location_service.dart';
import 'package:latlong2/latlong.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/cities/domain/entities/city.dart';
import '../errors/failures/failures.dart';
import '../usecases/usecase.dart';
import 'exceptions/location_exceptions.dart';
import 'location_provider.dart';

part 'get_nearest_city.g.dart';

class GetNearestCity implements Usecase<City, List<City>> {
  GetNearestCity({required this.locationService});

  final LocationService locationService;
  final _distance = const Distance();

  @override
  Future<Either<AppFailure, City>> call(List<City> cities) async {
    if (cities.isEmpty) {
      return left(const LocationUnknownFailure('Nenhuma cidade disponível.'));
    }

    // 1. Obtém localização
    final LatLng userLocation;
    try {
      userLocation = await locationService.getCurrentLocation();
    } on LocationException catch (e) {
      return left(_mapExceptionToFailure(e));
    }

    // 2. Filtra cidades que possuem coordenadas
    final citiesWithLocation = cities.where((c) => c.location != null).toList();
    if (citiesWithLocation.isEmpty) {
      return left(
        const LocationUnknownFailure(
          'Nenhuma cidade possui coordenadas cadastradas.',
        ),
      );
    }

    // 3. Encontra a mais próxima
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

    return right(nearest);
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

// ─── Provider ────────────────────────────────────────────────────────────────
@riverpod
GetNearestCity getNearestCity(Ref ref) {
  final LocationService locationService = ref.watch(locationServiceProvider);
  return GetNearestCity(locationService: locationService);
}
