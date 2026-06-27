// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cache_database_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(cacheDatabaseService)
final cacheDatabaseServiceProvider = CacheDatabaseServiceProvider._();

final class CacheDatabaseServiceProvider
    extends
        $FunctionalProvider<
          CacheDatabaseService,
          CacheDatabaseService,
          CacheDatabaseService
        >
    with $Provider<CacheDatabaseService> {
  CacheDatabaseServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cacheDatabaseServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cacheDatabaseServiceHash();

  @$internal
  @override
  $ProviderElement<CacheDatabaseService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CacheDatabaseService create(Ref ref) {
    return cacheDatabaseService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CacheDatabaseService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CacheDatabaseService>(value),
    );
  }
}

String _$cacheDatabaseServiceHash() =>
    r'e24b18224f6caa36e735122797ee2a10e6e0ae90';

@ProviderFor(initializedCacheService)
final initializedCacheServiceProvider = InitializedCacheServiceProvider._();

final class InitializedCacheServiceProvider
    extends
        $FunctionalProvider<
          AsyncValue<CacheDatabaseService>,
          CacheDatabaseService,
          FutureOr<CacheDatabaseService>
        >
    with
        $FutureModifier<CacheDatabaseService>,
        $FutureProvider<CacheDatabaseService> {
  InitializedCacheServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'initializedCacheServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$initializedCacheServiceHash();

  @$internal
  @override
  $FutureProviderElement<CacheDatabaseService> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<CacheDatabaseService> create(Ref ref) {
    return initializedCacheService(ref);
  }
}

String _$initializedCacheServiceHash() =>
    r'af262e2168e0759f05ad3e2bae35c2261f7d9cbd';

@ProviderFor(clearUnnecessaryCache)
final clearUnnecessaryCacheProvider = ClearUnnecessaryCacheProvider._();

final class ClearUnnecessaryCacheProvider
    extends $FunctionalProvider<AsyncValue<void>, void, FutureOr<void>>
    with $FutureModifier<void>, $FutureProvider<void> {
  ClearUnnecessaryCacheProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'clearUnnecessaryCacheProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$clearUnnecessaryCacheHash();

  @$internal
  @override
  $FutureProviderElement<void> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<void> create(Ref ref) {
    return clearUnnecessaryCache(ref);
  }
}

String _$clearUnnecessaryCacheHash() =>
    r'a3597700dfec1d293efab317bd39fd2877625edc';
