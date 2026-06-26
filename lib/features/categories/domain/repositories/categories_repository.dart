import 'package:ibiapabaapp/shared/models/category_entity.dart';
import 'package:ibiapabaapp/shared/models/child_category.dart';
import 'package:ibiapabaapp/shared/models/parent_category.dart';

abstract class CategoriesRepository {
  Future<List<ParentCategory>> getParentCategories({
    bool forceRefresh = false,
    CategoryEntity? entity,
  });
  Future<List<ChildCategory>> getChildrenCategories({
    required String parentId,
    bool forceRefresh = false,
    CategoryEntity? entity,
  });
}
