// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(locationLocalStorage)
final locationLocalStorageProvider = LocationLocalStorageProvider._();

final class LocationLocalStorageProvider
    extends
        $FunctionalProvider<
          LocationLocalStorage,
          LocationLocalStorage,
          LocationLocalStorage
        >
    with $Provider<LocationLocalStorage> {
  LocationLocalStorageProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'locationLocalStorageProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$locationLocalStorageHash();

  @$internal
  @override
  $ProviderElement<LocationLocalStorage> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LocationLocalStorage create(Ref ref) {
    return locationLocalStorage(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LocationLocalStorage value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LocationLocalStorage>(value),
    );
  }
}

String _$locationLocalStorageHash() =>
    r'42f9fee100050bfcf7e83b092ae30eaaceda1e98';

@ProviderFor(locationService)
final locationServiceProvider = LocationServiceProvider._();

final class LocationServiceProvider
    extends
        $FunctionalProvider<LocationService, LocationService, LocationService>
    with $Provider<LocationService> {
  LocationServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'locationServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$locationServiceHash();

  @$internal
  @override
  $ProviderElement<LocationService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  LocationService create(Ref ref) {
    return locationService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LocationService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LocationService>(value),
    );
  }
}

String _$locationServiceHash() => r'38d15292e1d1d4553c8f07a36b00411aa0a8d30e';

@ProviderFor(getNearestCity)
final getNearestCityProvider = GetNearestCityProvider._();

final class GetNearestCityProvider
    extends $FunctionalProvider<GetNearestCity, GetNearestCity, GetNearestCity>
    with $Provider<GetNearestCity> {
  GetNearestCityProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getNearestCityProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getNearestCityHash();

  @$internal
  @override
  $ProviderElement<GetNearestCity> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetNearestCity create(Ref ref) {
    return getNearestCity(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetNearestCity value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetNearestCity>(value),
    );
  }
}

String _$getNearestCityHash() => r'94b3742d0cb4e5fa05eeac5bec1596246da98494';
