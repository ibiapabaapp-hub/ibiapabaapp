// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(favoritesRemoteDatasource)
final favoritesRemoteDatasourceProvider = FavoritesRemoteDatasourceProvider._();

final class FavoritesRemoteDatasourceProvider
    extends
        $FunctionalProvider<
          FavoritesRemoteDatasource,
          FavoritesRemoteDatasource,
          FavoritesRemoteDatasource
        >
    with $Provider<FavoritesRemoteDatasource> {
  FavoritesRemoteDatasourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'favoritesRemoteDatasourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$favoritesRemoteDatasourceHash();

  @$internal
  @override
  $ProviderElement<FavoritesRemoteDatasource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FavoritesRemoteDatasource create(Ref ref) {
    return favoritesRemoteDatasource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FavoritesRemoteDatasource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FavoritesRemoteDatasource>(value),
    );
  }
}

String _$favoritesRemoteDatasourceHash() =>
    r'857d5a9f4d22ab8ff4c5ec2e2bb5a094dcc9e085';

@ProviderFor(favoritesLocalStorage)
final favoritesLocalStorageProvider = FavoritesLocalStorageProvider._();

final class FavoritesLocalStorageProvider
    extends
        $FunctionalProvider<
          FavoritesLocalStorage,
          FavoritesLocalStorage,
          FavoritesLocalStorage
        >
    with $Provider<FavoritesLocalStorage> {
  FavoritesLocalStorageProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'favoritesLocalStorageProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$favoritesLocalStorageHash();

  @$internal
  @override
  $ProviderElement<FavoritesLocalStorage> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FavoritesLocalStorage create(Ref ref) {
    return favoritesLocalStorage(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FavoritesLocalStorage value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FavoritesLocalStorage>(value),
    );
  }
}

String _$favoritesLocalStorageHash() =>
    r'08e5f940ef03ad29ae1643fd48d15bfeec0a1194';

@ProviderFor(favoritesRepository)
final favoritesRepositoryProvider = FavoritesRepositoryProvider._();

final class FavoritesRepositoryProvider
    extends
        $FunctionalProvider<
          FavoritesRepository,
          FavoritesRepository,
          FavoritesRepository
        >
    with $Provider<FavoritesRepository> {
  FavoritesRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'favoritesRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$favoritesRepositoryHash();

  @$internal
  @override
  $ProviderElement<FavoritesRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FavoritesRepository create(Ref ref) {
    return favoritesRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FavoritesRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FavoritesRepository>(value),
    );
  }
}

String _$favoritesRepositoryHash() =>
    r'120f9d97f77e275668e813e205f957f51e432631';
