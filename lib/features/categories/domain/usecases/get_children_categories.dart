import 'package:dartz/dartz.dart';
import 'package:ibiapabaapp/core/errors/failures/failures.dart';
import 'package:ibiapabaapp/core/usecases/usecase.dart';
import 'package:ibiapabaapp/shared/models/child_category.dart';
import 'package:ibiapabaapp/shared/models/category_entity.dart';
import 'package:ibiapabaapp/features/categories/domain/repositories/categories_repository.dart';

class GetChildrenCategories
    implements Usecase<List<ChildCategory>, GetChildrenCategoriesParams> {
  final CategoriesRepository repository;
  GetChildrenCategories(this.repository);

  @override
  Future<Either<AppFailure, List<ChildCategory>>> call(
    GetChildrenCategoriesParams params,
  ) {
    return repository.getChildrenCategories(
      parentId: params.parentId,
      entity: params.entity,
    );
  }
}

class GetChildrenCategoriesParams {
  final String parentId;
  final CategoryEntity? entity;
  GetChildrenCategoriesParams({required this.parentId, this.entity});
}
