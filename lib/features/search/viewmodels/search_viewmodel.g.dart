// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SearchViewModel)
final searchViewModelProvider = SearchViewModelProvider._();

final class SearchViewModelProvider
    extends $NotifierProvider<SearchViewModel, RecentSearchesData> {
  SearchViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchViewModelHash();

  @$internal
  @override
  SearchViewModel create() => SearchViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RecentSearchesData value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RecentSearchesData>(value),
    );
  }
}

String _$searchViewModelHash() => r'e07a5b94476108b9d242040305a3217430e02057';

abstract class _$SearchViewModel extends $Notifier<RecentSearchesData> {
  RecentSearchesData build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<RecentSearchesData, RecentSearchesData>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<RecentSearchesData, RecentSearchesData>,
              RecentSearchesData,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
