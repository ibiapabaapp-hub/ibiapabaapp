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

String _$citiesHash() => r'9a17886269c2a91339145a96178f6f54f8d38c25';

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
