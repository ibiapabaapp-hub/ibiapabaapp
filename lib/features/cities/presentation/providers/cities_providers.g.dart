// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cities_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(citiesLocalDatasource)
final citiesLocalDatasourceProvider = CitiesLocalDatasourceProvider._();

final class CitiesLocalDatasourceProvider
    extends
        $FunctionalProvider<
          CitiesLocalDatasource,
          CitiesLocalDatasource,
          CitiesLocalDatasource
        >
    with $Provider<CitiesLocalDatasource> {
  CitiesLocalDatasourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'citiesLocalDatasourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$citiesLocalDatasourceHash();

  @$internal
  @override
  $ProviderElement<CitiesLocalDatasource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CitiesLocalDatasource create(Ref ref) {
    return citiesLocalDatasource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CitiesLocalDatasource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CitiesLocalDatasource>(value),
    );
  }
}

String _$citiesLocalDatasourceHash() =>
    r'c3b3c277a1b3cf505fb8046b601245f4eaa54f64';

@ProviderFor(citiesRemoteDatasource)
final citiesRemoteDatasourceProvider = CitiesRemoteDatasourceProvider._();

final class CitiesRemoteDatasourceProvider
    extends
        $FunctionalProvider<
          CitiesRemoteDatasource,
          CitiesRemoteDatasource,
          CitiesRemoteDatasource
        >
    with $Provider<CitiesRemoteDatasource> {
  CitiesRemoteDatasourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'citiesRemoteDatasourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$citiesRemoteDatasourceHash();

  @$internal
  @override
  $ProviderElement<CitiesRemoteDatasource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CitiesRemoteDatasource create(Ref ref) {
    return citiesRemoteDatasource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CitiesRemoteDatasource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CitiesRemoteDatasource>(value),
    );
  }
}

String _$citiesRemoteDatasourceHash() =>
    r'516788a875643cc85ca42def1fa88c3dda07d4af';

@ProviderFor(citiesRepository)
final citiesRepositoryProvider = CitiesRepositoryProvider._();

final class CitiesRepositoryProvider
    extends
        $FunctionalProvider<
          CitiesRepository,
          CitiesRepository,
          CitiesRepository
        >
    with $Provider<CitiesRepository> {
  CitiesRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'citiesRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$citiesRepositoryHash();

  @$internal
  @override
  $ProviderElement<CitiesRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CitiesRepository create(Ref ref) {
    return citiesRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CitiesRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CitiesRepository>(value),
    );
  }
}

String _$citiesRepositoryHash() => r'2d2c99f3cf9e54aeaa30fd92d06acf58b4b99ccc';

@ProviderFor(getAllCities)
final getAllCitiesProvider = GetAllCitiesProvider._();

final class GetAllCitiesProvider
    extends $FunctionalProvider<GetAllCities, GetAllCities, GetAllCities>
    with $Provider<GetAllCities> {
  GetAllCitiesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getAllCitiesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getAllCitiesHash();

  @$internal
  @override
  $ProviderElement<GetAllCities> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetAllCities create(Ref ref) {
    return getAllCities(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetAllCities value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetAllCities>(value),
    );
  }
}

String _$getAllCitiesHash() => r'eb3e8c5629ed3ac335612cc310344c2530c92d14';

@ProviderFor(getCityById)
final getCityByIdProvider = GetCityByIdProvider._();

final class GetCityByIdProvider
    extends $FunctionalProvider<GetCityById, GetCityById, GetCityById>
    with $Provider<GetCityById> {
  GetCityByIdProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getCityByIdProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getCityByIdHash();

  @$internal
  @override
  $ProviderElement<GetCityById> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetCityById create(Ref ref) {
    return getCityById(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetCityById value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetCityById>(value),
    );
  }
}

String _$getCityByIdHash() => r'87f67c58dcaa701fe888eee7d7b1d87ddec178d5';

@ProviderFor(cityById)
final cityByIdProvider = CityByIdFamily._();

final class CityByIdProvider
    extends $FunctionalProvider<AsyncValue<City?>, City?, FutureOr<City?>>
    with $FutureModifier<City?>, $FutureProvider<City?> {
  CityByIdProvider._({
    required CityByIdFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'cityByIdProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$cityByIdHash();

  @override
  String toString() {
    return r'cityByIdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<City?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<City?> create(Ref ref) {
    final argument = this.argument as String;
    return cityById(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is CityByIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$cityByIdHash() => r'a8010c5d845ecd5d080169e62c0391a1aa2724ed';

final class CityByIdFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<City?>, String> {
  CityByIdFamily._()
    : super(
        retry: null,
        name: r'cityByIdProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CityByIdProvider call(String id) =>
      CityByIdProvider._(argument: id, from: this);

  @override
  String toString() => r'cityByIdProvider';
}
