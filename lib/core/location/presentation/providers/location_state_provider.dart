import 'package:ibiapabaapp/core/errors/failures/failures.dart';
import 'package:ibiapabaapp/core/location/data/datasources/location_local_storage.dart';
import 'package:ibiapabaapp/core/location/domain/entities/location_data.dart';
import 'package:ibiapabaapp/core/location/domain/tags/location_logtags.dart';
import 'package:ibiapabaapp/core/location/presentation/providers/location_providers.dart';
import 'package:ibiapabaapp/core/logger/handlers/controller_log_handler.dart';
import 'package:ibiapabaapp/core/logger/log_tags.dart';
import 'package:ibiapabaapp/core/logger/logger.dart';
import 'package:ibiapabaapp/shared/models/city.dart';
import 'package:ibiapabaapp/features/cities/presentation/providers/cities_providers.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'location_state_provider.g.dart';

@Riverpod(keepAlive: true)
class LocationState extends _$LocationState with ControllerLogHandler {
  @override
  late final Logger logger = ref.read(loggerProvider);

  @override
  LocationData build() => LocationData();

  @override
  LogFeature get feature => LogFeature.location;

  LocationLocalStorage get _storage => ref.read(locationLocalStorageProvider);

  Future<void> restore() async {
    try {
      // TODO: ajeitar latestCity
      // final latestCity = await _storage.loadLatestCity();
      final devicePosition = await ref
          .read(locationServiceProvider)
          .getCurrentLocation();

      if (!ref.mounted) return;

      state = state.copyWith(
        // currentCity: latestCity,
        devicePosition: devicePosition,
      );
    } catch (e) {
      logControllerError(action: LocationActions.restore, failure: e);
    }
  }

  // ─── City ──────────────────────────────────────────────────────────────────
  Future<void> setCurrentCity(City city) async {
    await _storage.saveCurrentCityId(city.id);
    state = state.copyWith(currentCity: city);
    logControllerSuccess(action: LocationActions.setCurrentCity);
  }

  Future<void> clearCurrentCity() async {
    await _storage.clearCurrentCity();
    state = state.copyWith(clearCity: true);
    logControllerSuccess(action: LocationActions.clearCurrentCity);
  }

  Future<AppFailure?> detectAndSetNearestCity() async {
    try {
      final cities = await ref
          .read(citiesRepositoryProvider)
          .getAllCities();

      if (!ref.mounted) return null;

      final nearestCity = await ref.read(getNearestCityProvider)(cities);

      if (!ref.mounted) return null;

      await setCurrentCity(nearestCity);
      logControllerSuccess(action: LocationActions.detectNearestCity);
      return null;
    } on AppFailure catch (failure) {
      logControllerError(
        action: LocationActions.detectNearestCity,
        failure: failure,
      );
      if (failure is LocationPermissionPermanentlyDeniedFailure) {
        ref.read(locationServiceProvider).openAppSettings();
      }
      return failure;
    } catch (e) {
      logControllerError(
        action: LocationActions.detectNearestCity,
        failure: e,
      );
      return null;
    }
  }

  // ─── Device Position ───────────────────────────────────────────────────────
  Future<void> resolveDevicePosition({bool force = false}) async {
    if (!force && state.devicePosition != null) return;

    try {
      final pos = await ref.read(locationServiceProvider).getCurrentLocation();
      state = state.copyWith(devicePosition: pos);
      logControllerSuccess(action: LocationActions.resolveDevicePosition);
    } catch (failure) {
      logControllerError(
        action: LocationActions.resolveDevicePosition,
        failure: failure,
      );
    }
  }
}

@riverpod
City? currentCity(Ref ref) {
  return ref.watch(locationStateProvider).currentCity;
}
