// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cities_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

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

String _$citiesHash() => r'dc26d76233b31edd4a47961459c9f9a924e91c76';

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
