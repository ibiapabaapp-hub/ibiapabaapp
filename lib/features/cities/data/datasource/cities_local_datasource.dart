import 'package:ibiapabaapp/shared/models/city.dart';

abstract class CitiesLocalDatasource {
  Future<List<City>> getCachedCities();
  Future<City?> getCityById(String id);
  Future<void> cacheCities(List<City> cities);
  Future<void> clearCache();
}