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

@ProviderFor(getAllFavoritesByProfile)
final getAllFavoritesByProfileProvider = GetAllFavoritesByProfileProvider._();

final class GetAllFavoritesByProfileProvider
    extends
        $FunctionalProvider<
          GetAllFavoritesByProfile,
          GetAllFavoritesByProfile,
          GetAllFavoritesByProfile
        >
    with $Provider<GetAllFavoritesByProfile> {
  GetAllFavoritesByProfileProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getAllFavoritesByProfileProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getAllFavoritesByProfileHash();

  @$internal
  @override
  $ProviderElement<GetAllFavoritesByProfile> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetAllFavoritesByProfile create(Ref ref) {
    return getAllFavoritesByProfile(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetAllFavoritesByProfile value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetAllFavoritesByProfile>(value),
    );
  }
}

String _$getAllFavoritesByProfileHash() =>
    r'21cd6acde96ee5b12bc5dcc14f8b666df249dc00';

@ProviderFor(pushFavorite)
final pushFavoriteProvider = PushFavoriteProvider._();

final class PushFavoriteProvider
    extends $FunctionalProvider<PushFavorite, PushFavorite, PushFavorite>
    with $Provider<PushFavorite> {
  PushFavoriteProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pushFavoriteProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pushFavoriteHash();

  @$internal
  @override
  $ProviderElement<PushFavorite> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PushFavorite create(Ref ref) {
    return pushFavorite(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PushFavorite value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PushFavorite>(value),
    );
  }
}

String _$pushFavoriteHash() => r'36b2121b31ba3fed1785d46ea73d1ca2e2ba25eb';

@ProviderFor(popFavorite)
final popFavoriteProvider = PopFavoriteProvider._();

final class PopFavoriteProvider
    extends $FunctionalProvider<PopFavorite, PopFavorite, PopFavorite>
    with $Provider<PopFavorite> {
  PopFavoriteProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'popFavoriteProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$popFavoriteHash();

  @$internal
  @override
  $ProviderElement<PopFavorite> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PopFavorite create(Ref ref) {
    return popFavorite(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PopFavorite value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PopFavorite>(value),
    );
  }
}

String _$popFavoriteHash() => r'2a3e329271e0c0f813261cd929ac99d9e91aaf1f';
