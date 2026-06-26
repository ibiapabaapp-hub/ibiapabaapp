// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medias_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(EntityMedias)
final entityMediasProvider = EntityMediasFamily._();

final class EntityMediasProvider
    extends $AsyncNotifierProvider<EntityMedias, List<Media>> {
  EntityMediasProvider._({
    required EntityMediasFamily super.from,
    required (EntityType, String) super.argument,
  }) : super(
         retry: null,
         name: r'entityMediasProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$entityMediasHash();

  @override
  String toString() {
    return r'entityMediasProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  EntityMedias create() => EntityMedias();

  @override
  bool operator ==(Object other) {
    return other is EntityMediasProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$entityMediasHash() => r'404176dc2b32289a7ce7f3ddcb91dbf01d8b7094';

final class EntityMediasFamily extends $Family
    with
        $ClassFamilyOverride<
          EntityMedias,
          AsyncValue<List<Media>>,
          List<Media>,
          FutureOr<List<Media>>,
          (EntityType, String)
        > {
  EntityMediasFamily._()
    : super(
        retry: null,
        name: r'entityMediasProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  EntityMediasProvider call(EntityType entityType, String entityId) =>
      EntityMediasProvider._(argument: (entityType, entityId), from: this);

  @override
  String toString() => r'entityMediasProvider';
}

abstract class _$EntityMedias extends $AsyncNotifier<List<Media>> {
  late final _$args = ref.$arg as (EntityType, String);
  EntityType get entityType => _$args.$1;
  String get entityId => _$args.$2;

  FutureOr<List<Media>> build(EntityType entityType, String entityId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Media>>, List<Media>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Media>>, List<Media>>,
              AsyncValue<List<Media>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args.$1, _$args.$2));
  }
}
