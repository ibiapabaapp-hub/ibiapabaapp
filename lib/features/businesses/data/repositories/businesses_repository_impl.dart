import 'package:dartz/dartz.dart';
import 'package:ibiapabaapp/core/errors/failures/failures.dart';
import 'package:ibiapabaapp/core/logger/log_tags.dart';
import 'package:ibiapabaapp/core/logger/handlers/repository_log_handler.dart';
import 'package:ibiapabaapp/features/businesses/data/datasource/businesses_local_datasource.dart';
import 'package:ibiapabaapp/features/businesses/data/datasource/businesses_remote_datasource.dart';
import 'package:ibiapabaapp/shared/models/business.dart';
import 'package:ibiapabaapp/features/businesses/domain/repositories/business_repository.dart';
import 'package:ibiapabaapp/features/businesses/domain/tags/businesses_logtags.dart';
import 'package:logger/logger.dart';

class BusinessesRepositoryImpl
    with RepositoryLogHandler
    implements BusinessesRepository {
  @override
  final Logger logger;
  final BusinessesRemoteDatasource remoteDatasource;
  final BusinessesLocalDatasource localDatasource;

  BusinessesRepositoryImpl({
    required this.remoteDatasource,
    required this.localDatasource,
    required this.logger,
  });

  @override
  LogFeature get feature => LogFeature.businesses;

  @override
  Future<Either<AppFailure, List<Business>>> getAllBusinesses() async {
    try {
      final cached = await localDatasource.getCachedBusinesses();
      if (cached.isNotEmpty) {
        return Right(cached);
      }

      final result = await remoteDatasource.getAllBusinesses();
      await localDatasource.cacheBusinesses(result);
      return Right(result);
    } catch (e, stack) {
      return Left(
        handleRepositoryError(
          exception: e,
          stackTrace: stack,
          action: BusinessAction.getAllBusinesses,
        ),
      );
    }
  }

  @override
  Future<Either<AppFailure, Business?>> getBusinessById(String id) async {
    try {
      final cached = await localDatasource.getBusinessById(id);
      if (cached != null) {
        return Right(cached);
      }

      final result = await remoteDatasource.getBusinessById(id);
      await localDatasource.cacheBusiness(result);
      return Right(result);
    } catch (e, stack) {
      return Left(
        handleRepositoryError(
          exception: e,
          stackTrace: stack,
          action: BusinessAction.getBusinessById,
        ),
      );
    }
  }
}
