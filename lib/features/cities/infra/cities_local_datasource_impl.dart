import 'package:ibiapabaapp/core/cache/cache_database_service.dart';
import 'package:ibiapabaapp/features/cities/data/datasource/cities_local_datasource.dart';
import 'package:ibiapabaapp/shared/models/city.dart';
import 'package:ibiapabaapp/features/cities/infra/models/cities_model.dart';

class CitiesLocalDatasourceImpl implements CitiesLocalDatasource {
  final CacheDatabaseService cacheService;
  static const _storeName = 'cities_cache';
  CitiesLocalDatasourceImpl({required this.cacheService});

  @override
  Future<List<City>> getCachedCities() async {
    return cacheService.getList<City>(
      storeName: _storeName,
      fromJson: CityModel.fromJson,
      maxAge: const Duration(days: 30),
    );
  }

  @override
  Future<City?> getCityById(String id) async {
    final cities = await getCachedCities();
    try {
      return cities.firstWhere((c) => c.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> cacheCities(List<City> cities) async {
    await cacheService.saveList<City>(
      storeName: _storeName,
      items: cities,
      toMap: CityModel.toMap,
    );
  }

  @override
  Future<void> clearCache() async {
    await cacheService.clear(storeName: _storeName);
  }
}
