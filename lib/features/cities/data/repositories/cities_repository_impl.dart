import 'package:dio/dio.dart';
import 'package:ibivibe/core/cache/cache_database_service.dart';
import 'package:ibivibe/core/logger/handlers/repository_log_handler.dart';
import 'package:ibivibe/core/logger/log_tags.dart';
import 'package:ibivibe/shared/models/city.dart';
import 'package:ibivibe/features/cities/domain/repositories/cities_repository.dart';
import 'package:ibivibe/features/cities/infra/models/cities_model.dart';
import 'package:logger/logger.dart';

class CitiesRepositoryImpl
    with RepositoryLogHandler
    implements CitiesRepository {
  @override
  final Logger logger;
  final Dio dio;
  final CacheDatabaseService cacheService;

  static const _storeName = 'cities_cache';

  CitiesRepositoryImpl({
    required this.logger,
    required this.dio,
    required this.cacheService,
  });

  @override
  LogFeature get feature => LogFeature.cities;

  @override
  Future<List<City>> getAllCities({bool forceRefresh = false}) async {
    if (!forceRefresh) {
      final cached = await cacheService.getList<City>(
        storeName: _storeName,
        fromJson: CityModel.fromJson,
        maxAge: const Duration(days: 30),
      );
      if (cached.isNotEmpty) return cached;
    }

    final response = await dio.get('/cities');
    final result = CityModel.fromJsonList(response.data);
    await cacheService.clear(storeName: _storeName);
    await cacheService.saveList<City>(
      storeName: _storeName,
      items: result,
      toMap: CityModel.toMap,
    );
    return result;
  }

  @override
  Future<City?> getCityById(String id) async {
    final cached = await cacheService.getList<City>(
      storeName: _storeName,
      fromJson: CityModel.fromJson,
      maxAge: const Duration(days: 30),
    );
    return cached.cast<City?>().firstWhere(
          (c) => c?.id == id,
          orElse: () => null,
        );
  }
}
