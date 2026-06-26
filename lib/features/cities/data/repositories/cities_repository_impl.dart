import 'package:dartz/dartz.dart';
import 'package:ibiapabaapp/core/errors/failures/failures.dart';
import 'package:ibiapabaapp/core/logger/log_tags.dart';
import 'package:ibiapabaapp/core/logger/handlers/repository_log_handler.dart';
import 'package:ibiapabaapp/features/cities/data/datasource/cities_local_datasource.dart';
import 'package:ibiapabaapp/features/cities/data/datasource/cities_remote_datasource.dart';
import 'package:ibiapabaapp/shared/models/city.dart';
import 'package:ibiapabaapp/features/cities/domain/repositories/cities_repository.dart';
import 'package:ibiapabaapp/features/cities/domain/tags/cities_logtags.dart';
import 'package:logger/logger.dart';

class CitiesRepositoryImpl
    with RepositoryLogHandler
    implements CitiesRepository {
  @override
  final Logger logger;
  final CitiesRemoteDatasource remoteDatasource;
  final CitiesLocalDatasource localDatasource;

  CitiesRepositoryImpl({
    required this.localDatasource,
    required this.remoteDatasource,
    required this.logger,
  });

  @override
  LogFeature get feature => LogFeature.cities;

  @override
  Future<Either<AppFailure, List<City>>> getAllCities({
    bool forceRefresh = false,
  }) async {
    try {
      if (!forceRefresh) {
        final cachedCities = await localDatasource.getCachedCities();
        if (cachedCities.isNotEmpty) return Right(cachedCities);
      }

      final remoteCities = await remoteDatasource.getAllCities();
      await localDatasource.clearCache();
      await localDatasource.cacheCities(remoteCities);

      return Right(remoteCities);
    } catch (e, stack) {
      return Left(
        handleRepositoryError(
          exception: e,
          stackTrace: stack,
          action: CityAction.getAllCities,
        ),
      );
    }
  }

  @override
  Future<Either<AppFailure, City?>> getCityById(String id) async {
    try {
      final city = await localDatasource.getCityById(id);
      return Right(city);
    } catch (e, stack) {
      return Left(
        handleRepositoryError(
          exception: e,
          stackTrace: stack,
          action: CityAction.getCityById,
        ),
      );
    }
  }
}
