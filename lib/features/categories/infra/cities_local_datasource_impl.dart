import 'package:ibiapabaapp/core/cache/cache_database_service.dart';
import 'package:ibiapabaapp/features/categories/data/datasources/categories_local_datasouce.dart';
import 'package:ibiapabaapp/features/categories/infra/models/child_category_model.dart';
import 'package:ibiapabaapp/features/categories/domain/entities/child_category.dart';

class CategoriesLocalDatasourceImpl implements CategoriesLocalDatasource {
  final CacheDatabaseService cacheService;
  CategoriesLocalDatasourceImpl({required this.cacheService});

  @override
  Future<List<ChildCategory>> getCachedChildren(String parentId) {
    return cacheService.getList<ChildCategory>(
      storeName: 'categories_children',
      key: parentId,
      fromJson: ChildCategoryModel.fromJson,
      maxAge: const Duration(days: 1),
    );
  }

  @override
  Future<void> cacheChildren(String parentId, List<ChildCategory> children) {
    return cacheService.saveList<ChildCategory>(
      storeName: 'categories_children',
      key: parentId,
      items: children,
      toMap: ChildCategoryModel.toMap,
    );
  }
}
