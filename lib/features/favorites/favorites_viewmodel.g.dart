// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FavoritesViewModel)
final favoritesViewModelProvider = FavoritesViewModelProvider._();

final class FavoritesViewModelProvider
    extends $NotifierProvider<FavoritesViewModel, FavoritesStateData> {
  FavoritesViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'favoritesViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$favoritesViewModelHash();

  @$internal
  @override
  FavoritesViewModel create() => FavoritesViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FavoritesStateData value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FavoritesStateData>(value),
    );
  }
}

String _$favoritesViewModelHash() =>
    r'c25c2da152c8a8a1623d0282c65c8f64ef659c8b';

abstract class _$FavoritesViewModel extends $Notifier<FavoritesStateData> {
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
