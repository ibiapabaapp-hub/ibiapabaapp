import 'package:ibiapabaapp/shared/models/category_entity.dart';
import 'package:ibiapabaapp/shared/models/child_category.dart';
import 'package:ibiapabaapp/shared/models/parent_category.dart';

abstract class CategoriesRemoteDatasource {
  Future<List<ParentCategory>> getParentCategories({CategoryEntity? entity});
  Future<List<ChildCategory>> getChildrenCategories({
    required String parentId,
    CategoryEntity? entity,
  });
}
