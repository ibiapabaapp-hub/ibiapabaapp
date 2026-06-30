// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categories_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(categoriesRepository)
final categoriesRepositoryProvider = CategoriesRepositoryProvider._();

final class CategoriesRepositoryProvider
    extends
        $FunctionalProvider<
          CategoriesRepository,
          CategoriesRepository,
          CategoriesRepository
        >
    with $Provider<CategoriesRepository> {
  CategoriesRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'categoriesRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$categoriesRepositoryHash();

  @$internal
  @override
  $ProviderElement<CategoriesRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CategoriesRepository create(Ref ref) {
    return categoriesRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CategoriesRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CategoriesRepository>(value),
    );
  }
}

String _$categoriesRepositoryHash() =>
    r'647acb399c2b67ec23d09d4c057089073dd3e1ea';

@ProviderFor(parentCategories)
final parentCategoriesProvider = ParentCategoriesFamily._();

final class ParentCategoriesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ParentCategory>>,
          List<ParentCategory>,
          FutureOr<List<ParentCategory>>
        >
    with
        $FutureModifier<List<ParentCategory>>,
        $FutureProvider<List<ParentCategory>> {
  ParentCategoriesProvider._({
    required ParentCategoriesFamily super.from,
    required CategoryEntity super.argument,
  }) : super(
         retry: null,
         name: r'parentCategoriesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$parentCategoriesHash();

  @override
  String toString() {
    return r'parentCategoriesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<ParentCategory>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ParentCategory>> create(Ref ref) {
    final argument = this.argument as CategoryEntity;
    return parentCategories(ref, entity: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ParentCategoriesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$parentCategoriesHash() => r'8d57dda8a16796cf3d0225a43644cacec92e4fe2';

final class ParentCategoriesFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<ParentCategory>>,
          CategoryEntity
        > {
  ParentCategoriesFamily._()
    : super(
        retry: null,
        name: r'parentCategoriesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ParentCategoriesProvider call({required CategoryEntity entity}) =>
      ParentCategoriesProvider._(argument: entity, from: this);

  @override
  String toString() => r'parentCategoriesProvider';
}

@ProviderFor(childCategories)
final childCategoriesProvider = ChildCategoriesFamily._();

final class ChildCategoriesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ChildCategory>>,
          List<ChildCategory>,
          FutureOr<List<ChildCategory>>
        >
    with
        $FutureModifier<List<ChildCategory>>,
        $FutureProvider<List<ChildCategory>> {
  ChildCategoriesProvider._({
    required ChildCategoriesFamily super.from,
    required ({String parentId, CategoryEntity? entity}) super.argument,
  }) : super(
         retry: null,
         name: r'childCategoriesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$childCategoriesHash();

  @override
  String toString() {
    return r'childCategoriesProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<List<ChildCategory>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ChildCategory>> create(Ref ref) {
    final argument =
        this.argument as ({String parentId, CategoryEntity? entity});
    return childCategories(
      ref,
      parentId: argument.parentId,
      entity: argument.entity,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ChildCategoriesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$childCategoriesHash() => r'a095065531638284a6d38daf276b56a264920651';

final class ChildCategoriesFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<ChildCategory>>,
          ({String parentId, CategoryEntity? entity})
        > {
  ChildCategoriesFamily._()
    : super(
        retry: null,
        name: r'childCategoriesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ChildCategoriesProvider call({
    required String parentId,
    CategoryEntity? entity,
  }) => ChildCategoriesProvider._(
    argument: (parentId: parentId, entity: entity),
    from: this,
  );

  @override
  String toString() => r'childCategoriesProvider';
}
