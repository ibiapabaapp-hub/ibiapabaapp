// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites_state_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FavoritesState)
final favoritesStateProvider = FavoritesStateProvider._();

final class FavoritesStateProvider
    extends $NotifierProvider<FavoritesState, FavoritesStateData> {
  FavoritesStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'favoritesStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$favoritesStateHash();

  @$internal
  @override
  FavoritesState create() => FavoritesState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FavoritesStateData value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FavoritesStateData>(value),
    );
  }
}

String _$favoritesStateHash() => r'd3dd0496cbaf988b7e63f9340ee1a277c66d245b';

abstract class _$FavoritesState extends $Notifier<FavoritesStateData> {
  FavoritesStateData build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<FavoritesStateData, FavoritesStateData>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<FavoritesStateData, FavoritesStateData>,
              FavoritesStateData,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
