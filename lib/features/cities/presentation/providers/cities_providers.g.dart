// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cities_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

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

String _$citiesRepositoryHash() => r'b06247062fa205a3252ec1a0fb8c9234e8af4493';

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

String _$cityByIdHash() => r'19cc2e902be529f63c499c29dd27473c23be2567';

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
