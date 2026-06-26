import 'package:ibiapabaapp/core/cache/cache_database_provider.dart';
import 'package:ibiapabaapp/core/logger/logger.dart';
import 'package:ibiapabaapp/core/network/dio_provider.dart';
import 'package:ibiapabaapp/features/cities/data/repositories/cities_repository_impl.dart';
import 'package:ibiapabaapp/features/cities/domain/repositories/cities_repository.dart';
import 'package:ibiapabaapp/shared/models/city.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cities_providers.g.dart';

@riverpod
CitiesRepository citiesRepository(Ref ref) {
  final logger = ref.read(loggerProvider);
  final dio = ref.watch(dioProvider);
  final cacheService = ref.watch(cacheDatabaseServiceProvider);

  return CitiesRepositoryImpl(
    dio: dio,
    cacheService: cacheService,
    logger: logger,
  );
}

@riverpod
Future<City?> cityById(Ref ref, String id) async {
  final repository = ref.watch(citiesRepositoryProvider);
  return repository.getCityById(id);
}
