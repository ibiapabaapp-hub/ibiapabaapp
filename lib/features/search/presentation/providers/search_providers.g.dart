// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(searchLocalStorage)
final searchLocalStorageProvider = SearchLocalStorageProvider._();

final class SearchLocalStorageProvider
    extends
        $FunctionalProvider<
          SearchLocalStorage,
          SearchLocalStorage,
          SearchLocalStorage
        >
    with $Provider<SearchLocalStorage> {
  SearchLocalStorageProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchLocalStorageProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchLocalStorageHash();

  @$internal
  @override
  $ProviderElement<SearchLocalStorage> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SearchLocalStorage create(Ref ref) {
    return searchLocalStorage(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SearchLocalStorage value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SearchLocalStorage>(value),
    );
  }
}

String _$searchLocalStorageHash() =>
    r'8f006aac5fc4c972a1e0f2f7699bb976d20238d3';

@ProviderFor(searchRemoteDatasource)
final searchRemoteDatasourceProvider = SearchRemoteDatasourceProvider._();

final class SearchRemoteDatasourceProvider
    extends
        $FunctionalProvider<
          SearchRemoteDatasource,
          SearchRemoteDatasource,
          SearchRemoteDatasource
        >
    with $Provider<SearchRemoteDatasource> {
  SearchRemoteDatasourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchRemoteDatasourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchRemoteDatasourceHash();

  @$internal
  @override
  $ProviderElement<SearchRemoteDatasource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SearchRemoteDatasource create(Ref ref) {
    return searchRemoteDatasource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SearchRemoteDatasource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SearchRemoteDatasource>(value),
    );
  }
}

String _$searchRemoteDatasourceHash() =>
    r'a6c73137670e05dbc776add2b1c48226e67ae125';

@ProviderFor(searchRepository)
final searchRepositoryProvider = SearchRepositoryProvider._();

final class SearchRepositoryProvider
    extends
        $FunctionalProvider<
          SearchRepository,
          SearchRepository,
          SearchRepository
        >
    with $Provider<SearchRepository> {
  SearchRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchRepositoryHash();

  @$internal
  @override
  $ProviderElement<SearchRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SearchRepository create(Ref ref) {
    return searchRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SearchRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SearchRepository>(value),
    );
  }
}

String _$searchRepositoryHash() => r'4557a4d5b26209087d3974071bcdabb51e6e6a69';

@ProviderFor(performSearch)
final performSearchProvider = PerformSearchProvider._();

final class PerformSearchProvider
    extends $FunctionalProvider<PerformSearch, PerformSearch, PerformSearch>
    with $Provider<PerformSearch> {
  PerformSearchProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'performSearchProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$performSearchHash();

  @$internal
  @override
  $ProviderElement<PerformSearch> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PerformSearch create(Ref ref) {
    return performSearch(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PerformSearch value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PerformSearch>(value),
    );
  }
}

String _$performSearchHash() => r'94834ba1c725adb4eb517b6d53f46029b4246bb0';

@ProviderFor(SearchNotifier)
final searchProvider = SearchNotifierProvider._();

final class SearchNotifierProvider
    extends $AsyncNotifierProvider<SearchNotifier, List<SearchResult>> {
  SearchNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchNotifierHash();

  @$internal
  @override
  SearchNotifier create() => SearchNotifier();
}

String _$searchNotifierHash() => r'2a75b62416114bb760518ab20f48e33b82f37843';

abstract class _$SearchNotifier extends $AsyncNotifier<List<SearchResult>> {
  FutureOr<List<SearchResult>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<SearchResult>>, List<SearchResult>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<SearchResult>>, List<SearchResult>>,
              AsyncValue<List<SearchResult>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
