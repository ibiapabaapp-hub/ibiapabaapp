// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tags_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(tagsRepository)
final tagsRepositoryProvider = TagsRepositoryProvider._();

final class TagsRepositoryProvider
    extends $FunctionalProvider<TagsRepository, TagsRepository, TagsRepository>
    with $Provider<TagsRepository> {
  TagsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tagsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tagsRepositoryHash();

  @$internal
  @override
  $ProviderElement<TagsRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TagsRepository create(Ref ref) {
    return tagsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TagsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TagsRepository>(value),
    );
  }
}

String _$tagsRepositoryHash() => r'581472c2b320c0a868ca20f51ac14f573e2b93da';

@ProviderFor(tagGroups)
final tagGroupsProvider = TagGroupsProvider._();

final class TagGroupsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<TagGroup>>,
          List<TagGroup>,
          FutureOr<List<TagGroup>>
        >
    with $FutureModifier<List<TagGroup>>, $FutureProvider<List<TagGroup>> {
  TagGroupsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tagGroupsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tagGroupsHash();

  @$internal
  @override
  $FutureProviderElement<List<TagGroup>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<TagGroup>> create(Ref ref) {
    return tagGroups(ref);
  }
}

String _$tagGroupsHash() => r'e31c42fc52679d836b13ae1722c84d6152c02272';
