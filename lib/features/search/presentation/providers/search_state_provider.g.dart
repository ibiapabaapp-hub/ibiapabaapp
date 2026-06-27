// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_state_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SearchState)
final searchStateProvider = SearchStateProvider._();

final class SearchStateProvider
    extends $NotifierProvider<SearchState, RecentSearchesData> {
  SearchStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchStateHash();

  @$internal
  @override
  SearchState create() => SearchState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RecentSearchesData value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RecentSearchesData>(value),
    );
  }
}

String _$searchStateHash() => r'82e078779199fb8d037c19858b33005e71a87d35';

abstract class _$SearchState extends $Notifier<RecentSearchesData> {
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
