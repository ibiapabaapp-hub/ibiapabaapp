// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_state_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LocationState)
final locationStateProvider = LocationStateProvider._();

final class LocationStateProvider
    extends $NotifierProvider<LocationState, LocationData> {
  LocationStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'locationStateProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$locationStateHash();

  @$internal
  @override
  LocationState create() => LocationState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LocationData value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LocationData>(value),
    );
  }
}

String _$locationStateHash() => r'2d923a5cecd33cc8451429ad285eae21a5e9e025';

abstract class _$LocationState extends $Notifier<LocationData> {
  LocationData build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<LocationData, LocationData>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<LocationData, LocationData>,
              LocationData,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(currentCity)
final currentCityProvider = CurrentCityProvider._();

final class CurrentCityProvider extends $FunctionalProvider<City?, City?, City?>
    with $Provider<City?> {
  CurrentCityProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentCityProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentCityHash();

  @$internal
  @override
  $ProviderElement<City?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  City? create(Ref ref) {
    return currentCity(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(City? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<City?>(value),
    );
  }
}

String _$currentCityHash() => r'ee4492fd22a4ea2539f7f4ee3d160ea2048e38c2';
