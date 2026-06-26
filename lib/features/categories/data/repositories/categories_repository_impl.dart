import 'package:dartz/dartz.dart';
import 'package:ibiapabaapp/core/errors/failures/failures.dart';
import 'package:ibiapabaapp/core/logger/handlers/repository_log_handler.dart';
import 'package:ibiapabaapp/core/logger/log_tags.dart';
import 'package:ibiapabaapp/features/categories/data/datasources/categories_local_datasouce.dart';
import 'package:ibiapabaapp/features/categories/data/datasources/categories_remote_datasouce.dart';
import 'package:ibiapabaapp/shared/models/category_entity.dart';
import 'package:ibiapabaapp/shared/models/child_category.dart';
import 'package:ibiapabaapp/shared/models/parent_category.dart';
import 'package:ibiapabaapp/features/categories/domain/repositories/categories_repository.dart';
import 'package:ibiapabaapp/features/categories/domain/tags/categories_logtags.dart';
import 'package:logger/logger.dart';

class CategoriesRepositoryImpl
    with RepositoryLogHandler
    implements CategoriesRepository {
  @override
  final Logger logger;
  @override
  LogFeature get feature => LogFeature.categories;

  final CategoriesLocalDatasource localDatasource;
  final CategoriesRemoteDatasource remoteDatasource;

  CategoriesRepositoryImpl({
    required this.logger,
    required this.remoteDatasource,
    required this.localDatasource,
  });

  @override
  Future<Either<AppFailure, List<ParentCategory>>> getParentCategories({
    bool forceRefresh = false,
    CategoryEntity? entity,
  }) async {
    try {
      final remoteCategories = await remoteDatasource.getParentCategories(
        entity: entity,
      );
      return Right(remoteCategories);
    } catch (e, stack) {
      return Left(
        handleRepositoryError(
          exception: e,
          stackTrace: stack,
          action: CategoryAction.getParentCategories,
        ),
      );
    }
  }

  @override
  Future<Either<AppFailure, List<ChildCategory>>> getChildrenCategories({
    required String parentId,
    bool forceRefresh = false,
    CategoryEntity? entity,
  }) async {
    try {
      if (!forceRefresh) {
        final cached = await localDatasource.getCachedChildren(parentId);
        if (cached.isNotEmpty) return Right(cached);
      }

      final remote = await remoteDatasource.getChildrenCategories(
        parentId: parentId,
        entity: entity,
      );
      localDatasource.cacheChildren(parentId, remote);

      return Right(remote);
    } catch (e, stack) {
      return Left(
        handleRepositoryError(
          exception: e,
          stackTrace: stack,
          action: CategoryAction.getChildrenCategories,
        ),
      );
    }
  }
}
