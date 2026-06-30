// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cities_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CitiesViewModel)
final citiesViewModelProvider = CitiesViewModelProvider._();

final class CitiesViewModelProvider
    extends $AsyncNotifierProvider<CitiesViewModel, List<City>> {
  CitiesViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'citiesViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$citiesViewModelHash();

  @$internal
  @override
  CitiesViewModel create() => CitiesViewModel();
}

String _$citiesViewModelHash() => r'7ab072ab375332baff92a6dc5fe341a06b25e6f7';

abstract class _$CitiesViewModel extends $AsyncNotifier<List<City>> {
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
