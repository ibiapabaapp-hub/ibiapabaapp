import 'package:dio/dio.dart';
import 'package:ibiapabaapp/core/network/dio_exception_to_app_exception_mapper.dart';
import 'package:ibiapabaapp/features/categories/data/datasources/categories_remote_datasouce.dart';
import 'package:ibiapabaapp/features/categories/domain/entities/category_entity.dart';
import 'package:ibiapabaapp/features/categories/infra/models/child_category_model.dart';
import 'package:ibiapabaapp/features/categories/infra/models/parent_category_model.dart';
import 'package:ibiapabaapp/features/categories/domain/entities/child_category.dart';
import 'package:ibiapabaapp/features/categories/domain/entities/parent_category.dart';

class CategoriesRemoteDatasourceImpl implements CategoriesRemoteDatasource {
  final Dio dio;
  CategoriesRemoteDatasourceImpl({required this.dio});

  @override
  Future<List<ParentCategory>> getParentCategories({
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
    CategoryEntity? entity,
  }) async {
    final String query = entity == null ? '' : '?entity=${entity.name}';

    try {
      final response = await dio.get(
        '/categories/parents/$parentId/children$query',
      );
      final data = response.data;

      if (data is List) {
        return ChildCategoryModel.fromJsonList(data);
      }

      return [];
    } on DioException catch (e) {
      throw DioExceptionToAppExceptionMapper.map(e);
    }
  }
}
