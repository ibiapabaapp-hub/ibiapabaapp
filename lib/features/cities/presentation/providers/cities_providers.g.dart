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
          CitiesLocalDatasourceImpl,
          CitiesLocalDatasourceImpl,
          CitiesLocalDatasourceImpl
        >
    with $Provider<CitiesLocalDatasourceImpl> {
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
  $ProviderElement<CitiesLocalDatasourceImpl> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CitiesLocalDatasourceImpl create(Ref ref) {
    return citiesLocalDatasource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CitiesLocalDatasourceImpl value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CitiesLocalDatasourceImpl>(value),
    );
  }
}

String _$citiesLocalDatasourceHash() =>
    r'9623994ec245a0f6fc1369ffd4972c8a32f4f1a8';

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

String _$citiesRepositoryHash() => r'124679c31e63c0ef7b99fd80a94e0471176147c3';

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

@ProviderFor(Cities)
final citiesProvider = CitiesProvider._();

final class CitiesProvider extends $AsyncNotifierProvider<Cities, List<City>> {
  CitiesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'citiesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$citiesHash();

  @$internal
  @override
  Cities create() => Cities();
}

String _$citiesHash() => r'2ab5c7870b82f673d416b0366b8a9437b0e44bd9';

abstract class _$Cities extends $AsyncNotifier<List<City>> {
  FutureOr<List<City>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<City>>, List<City>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<City>>, List<City>>,
              AsyncValue<List<City>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
