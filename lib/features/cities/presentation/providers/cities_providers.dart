import 'package:ibiapabaapp/core/cache/cache_database_provider.dart';
import 'package:ibiapabaapp/core/logger/logger.dart';
import 'package:ibiapabaapp/core/network/dio_provider.dart';
import 'package:ibiapabaapp/features/cities/data/datasource/cities_local_datasource.dart';
import 'package:ibiapabaapp/features/cities/data/datasource/cities_remote_datasource.dart';
import 'package:ibiapabaapp/features/cities/data/repositories/cities_repository_impl.dart';
import 'package:ibiapabaapp/features/cities/domain/entities/city.dart';
import 'package:ibiapabaapp/features/cities/domain/repositories/cities_repository.dart';
import 'package:ibiapabaapp/features/cities/domain/usecases/get_all_cities.dart';
import 'package:ibiapabaapp/features/cities/domain/usecases/get_city_by_id.dart';
import 'package:ibiapabaapp/features/cities/infra/cities_local_datasource_impl.dart';
import 'package:ibiapabaapp/features/cities/infra/cities_remote_datasource_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cities_providers.g.dart';

// DATA
@riverpod
CitiesLocalDatasource citiesLocalDatasource(Ref ref) {
  final service = ref.watch(cacheDatabaseServiceProvider);
  return CitiesLocalDatasourceImpl(cacheService: service);
}

@riverpod
CitiesRemoteDatasource citiesRemoteDatasource(Ref ref) {
  final dio = ref.watch(dioProvider);
  return CitiesRemoteDatasourceImpl(dio);
}

@riverpod
CitiesRepository citiesRepository(Ref ref) {
  final logger = ref.read(loggerProvider);
  final localDatasource = ref.watch(citiesLocalDatasourceProvider);
  final remoteDatasource = ref.watch(citiesRemoteDatasourceProvider);

  return CitiesRepositoryImpl(
    remoteDatasource: remoteDatasource,
    localDatasource: localDatasource,
    logger: logger,
  );
}

// USECASES
@riverpod
GetAllCities getAllCities(Ref ref) {
  final repository = ref.watch(citiesRepositoryProvider);
  return GetAllCities(repository);
}

@riverpod
GetCityById getCityById(Ref ref) {
  final repository = ref.watch(citiesRepositoryProvider);
  return GetCityById(repository);
}

@riverpod
Future<City?> cityById(Ref ref, String id) async {
  final localCache = ref.watch(citiesLocalDatasourceProvider);
  return localCache.getCityById(id);
}
