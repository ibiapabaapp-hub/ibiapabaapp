import 'package:ibivibe/core/cache/cache_database_provider.dart';
import 'package:ibivibe/core/logger/logger.dart';
import 'package:ibivibe/core/network/dio_provider.dart';
import 'package:ibivibe/features/cities/data/repositories/cities_repository_impl.dart';
import 'package:ibivibe/features/cities/domain/repositories/cities_repository.dart';
import 'package:ibivibe/shared/models/city.dart';
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
