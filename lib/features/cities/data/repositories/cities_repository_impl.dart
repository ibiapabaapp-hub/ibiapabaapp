import 'package:dartz/dartz.dart';
import 'package:ibiapabaapp/core/errors/exceptions/exceptions.dart';
import 'package:ibiapabaapp/core/errors/exceptions/global_exception_to_failure_mapper.dart';
import 'package:ibiapabaapp/core/errors/failures/failures.dart';
import 'package:ibiapabaapp/core/logger/log_tags.dart';
import 'package:ibiapabaapp/core/logger/logger.dart';
import 'package:ibiapabaapp/features/cities/data/datasource/cities_local_datasource.dart';
import 'package:ibiapabaapp/features/cities/data/datasource/cities_remote_datasource.dart';
import 'package:ibiapabaapp/features/cities/domain/entities/city.dart';
import 'package:ibiapabaapp/features/cities/domain/repositories/cities_repository.dart';

class CitiesRepositoryImpl implements CitiesRepository {
  final CitiesRemoteDatasource remoteDatasource;
  final CitiesLocalDatasource localDatasource;

  CitiesRepositoryImpl({
    required this.localDatasource,
    required this.remoteDatasource,
  });

  Failure _handleError(dynamic e, StackTrace stack, String tag) {
    final code = e is AppException ? e.code : null;
    logger.e(
      '${LogTags.repository}${LogTags.cities}$tag',
      error: {
        'exception': e.runtimeType.toString(),
        'code': code,
        'message': e.toString(),
      },
      stackTrace: stack,
    );

    // TODO: CitiesExceptionToFailureMapper para erros específicos da funcionalidade
    return GlobalExceptionToFailureMapper.map(e);
  }

  @override
  Future<Either<Failure, List<City>>> getAllCities() async {
    try {
      final cachedCities = await localDatasource.getCachedCities();
      if (cachedCities.isNotEmpty) {
        logger.d('retrieved cities from cache');
        return Right(cachedCities);
      }

      final remoteCities = await remoteDatasource.getAllCities();
      await localDatasource.cacheCities(remoteCities);

      logger.d('retrieved cities from remote');
      return Right(remoteCities);
    } catch (e, stack) {
      return Left(_handleError(e, stack, LogTags.getAllCities));
    }
  }
}
