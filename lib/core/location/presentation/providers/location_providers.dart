import 'package:ibivibe/core/cache/cache_database_provider.dart';
import 'package:ibivibe/core/location/data/datasources/location_local_storage.dart';
import 'package:ibivibe/core/location/infra/location_local_storage_impl.dart';
import 'package:ibivibe/core/location/domain/usecases/get_nearest_city.dart';
import 'package:ibivibe/core/location/infra/location_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'location_providers.g.dart';

@riverpod
LocationLocalStorage locationLocalStorage(Ref ref) {
  final cacheDatabaseService = ref.read(cacheDatabaseServiceProvider);
  return LocationLocalStorageImpl(cacheDatabaseService);
}

@riverpod
LocationService locationService(Ref ref) {
  return LocationService();
}

@riverpod
GetNearestCity getNearestCity(Ref ref) {
  final locationService = ref.watch(locationServiceProvider);
  return GetNearestCity(locationService: locationService);
}
