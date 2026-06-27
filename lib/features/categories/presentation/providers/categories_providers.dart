import 'package:ibivibe/core/cache/cache_database_provider.dart';
import 'package:ibivibe/core/logger/logger.dart';
import 'package:ibivibe/core/network/dio_provider.dart';
import 'package:ibivibe/features/categories/data/repositories/categories_repository_impl.dart';
import 'package:ibivibe/shared/models/category_entity.dart';
import 'package:ibivibe/shared/models/child_category.dart';
import 'package:ibivibe/shared/models/parent_category.dart';
import 'package:ibivibe/features/categories/domain/repositories/categories_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'categories_providers.g.dart';

@riverpod
CategoriesRepository categoriesRepository(Ref ref) {
  final logger = ref.read(loggerProvider);
  final dio = ref.watch(dioProvider);
  final cacheService = ref.watch(cacheDatabaseServiceProvider);

  return CategoriesRepositoryImpl(
    dio: dio,
    cacheService: cacheService,
    logger: logger,
  );
}

@riverpod
Future<List<ParentCategory>> parentCategories(
  Ref ref, {
  required CategoryEntity entity,
}) {
  final repository = ref.watch(categoriesRepositoryProvider);
  return repository.getParentCategories(entity: entity);
}

@riverpod
Future<List<ChildCategory>> childCategories(
  Ref ref, {
  required String parentId,
  CategoryEntity? entity,
}) async {
  if (parentId.startsWith('mock')) return [];

  final link = ref.keepAlive();

  final repository = ref.watch(categoriesRepositoryProvider);
  try {
    final categories = await repository.getChildrenCategories(
      parentId: parentId,
      entity: entity,
    );
    return categories;
  } catch (e) {
    link.close();
    rethrow;
  }
}
