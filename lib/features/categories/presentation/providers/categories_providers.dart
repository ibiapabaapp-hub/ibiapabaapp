import 'package:ibiapabaapp/core/cache/cache_database_provider.dart';
import 'package:ibiapabaapp/core/logger/logger.dart';
import 'package:ibiapabaapp/core/network/dio_provider.dart';
import 'package:ibiapabaapp/features/categories/data/datasources/categories_local_datasouce.dart';
import 'package:ibiapabaapp/features/categories/data/datasources/categories_remote_datasouce.dart';
import 'package:ibiapabaapp/features/categories/data/repositories/categories_repository_impl.dart';
import 'package:ibiapabaapp/shared/models/category_entity.dart';
import 'package:ibiapabaapp/shared/models/child_category.dart';
import 'package:ibiapabaapp/shared/models/parent_category.dart';
import 'package:ibiapabaapp/features/categories/domain/repositories/categories_repository.dart';
import 'package:ibiapabaapp/features/categories/domain/usecases/get_children_categories.dart';
import 'package:ibiapabaapp/features/categories/domain/usecases/get_parent_categories.dart';
import 'package:ibiapabaapp/features/categories/infra/categories_local_datasource_impl.dart';
import 'package:ibiapabaapp/features/categories/infra/categories_remote_datasource_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'categories_providers.g.dart';

@riverpod
CategoriesLocalDatasource categoriesLocalDatasource(Ref ref) {
  final service = ref.watch(cacheDatabaseServiceProvider);
  return CategoriesLocalDatasourceImpl(cacheService: service);
}

@riverpod
CategoriesRemoteDatasource categoriesRemoteDatasource(Ref ref) {
  final dio = ref.watch(dioProvider);
  return CategoriesRemoteDatasourceImpl(dio: dio);
}

@riverpod
CategoriesRepository categoriesRepository(Ref ref) {
  final logger = ref.read(loggerProvider);
  final localDatasource = ref.watch(categoriesLocalDatasourceProvider);
  final remoteDatasource = ref.watch(categoriesRemoteDatasourceProvider);

  return CategoriesRepositoryImpl(
    localDatasource: localDatasource,
    remoteDatasource: remoteDatasource,
    logger: logger,
  );
}

@riverpod
GetParentCategories getParentCategories(Ref ref) {
  final repository = ref.watch(categoriesRepositoryProvider);
  return GetParentCategories(repository);
}

@riverpod
GetChildrenCategories getChildrenCategories(Ref ref) {
  final repository = ref.watch(categoriesRepositoryProvider);
  return GetChildrenCategories(repository);
}

// USECASES
@riverpod
Future<List<ParentCategory>> parentCategories(
  Ref ref, {
  required CategoryEntity entity,
}) {
  final getParentCategories = ref.watch(getParentCategoriesProvider);
  return getParentCategories(GetParentCategoriesParams(entity: entity)).then(
    (result) => result.fold(
      (failure) => throw Exception(failure.message),
      (categories) => categories,
    ),
  );
}

@riverpod
Future<List<ChildCategory>> childCategories(
  Ref ref, {
  required String parentId,
  CategoryEntity? entity,
}) async {
  if (parentId.startsWith('mock')) return [];

  final link = ref.keepAlive();

  final getChildrenCategories = ref.watch(getChildrenCategoriesProvider);
  final result = await getChildrenCategories(
    GetChildrenCategoriesParams(parentId: parentId, entity: entity),
  );

  return result.fold((failure) {
    link.close();
    throw Exception(failure.message);
  }, (categories) => categories);
}
