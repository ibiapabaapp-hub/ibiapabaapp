import 'package:dio/dio.dart';
import 'package:ibivibe/core/cache/cache_database_service.dart';
import 'package:ibivibe/core/logger/handlers/repository_log_handler.dart';
import 'package:ibivibe/core/logger/log_tags.dart';
import 'package:ibivibe/core/network/dio_exception_to_app_exception_mapper.dart';
import 'package:ibivibe/shared/models/category_entity.dart';
import 'package:ibivibe/shared/models/child_category.dart';
import 'package:ibivibe/shared/models/parent_category.dart';
import 'package:ibivibe/features/categories/domain/repositories/categories_repository.dart';
import 'package:ibivibe/features/categories/infra/models/child_category_model.dart';
import 'package:ibivibe/features/categories/infra/models/parent_category_model.dart';
import 'package:logger/logger.dart';

class CategoriesRepositoryImpl
    with RepositoryLogHandler
    implements CategoriesRepository {
  @override
  final Logger logger;
  @override
  LogFeature get feature => LogFeature.categories;

  final Dio dio;
  final CacheDatabaseService cacheService;

  CategoriesRepositoryImpl({
    required this.logger,
    required this.dio,
    required this.cacheService,
  });

  @override
  Future<List<ParentCategory>> getParentCategories({
    bool forceRefresh = false,
    CategoryEntity? entity,
  }) async {
    final String query = entity == null ? '' : '?entity=${entity.name}';

    try {
      final response = await dio.get('/categories/parents$query');
      final data = response.data;

      if (data is List) {
        return ParentCategoryModel.fromJsonList(data);
      }

      return [];
    } on DioException catch (e) {
      throw DioExceptionToAppExceptionMapper.map(e);
    }
  }

  @override
  Future<List<ChildCategory>> getChildrenCategories({
    required String parentId,
    bool forceRefresh = false,
    CategoryEntity? entity,
  }) async {
    try {
      if (!forceRefresh) {
        final cached = await cacheService.getList<ChildCategory>(
          storeName: 'categories_children',
          key: parentId,
          fromJson: ChildCategoryModel.fromJson,
          maxAge: const Duration(days: 1),
        );
        if (cached.isNotEmpty) return cached;
      }

      final String query = entity == null ? '' : '?entity=${entity.name}';
      final response = await dio.get(
        '/categories/parents/$parentId/children$query',
      );
      final data = response.data;

      if (data is List) {
        final remote = ChildCategoryModel.fromJsonList(data);
        await cacheService.saveList<ChildCategory>(
          storeName: 'categories_children',
          key: parentId,
          items: remote,
          toMap: ChildCategoryModel.toMap,
        );
        return remote;
      }

      return [];
    } on DioException catch (e) {
      throw DioExceptionToAppExceptionMapper.map(e);
    }
  }
}
