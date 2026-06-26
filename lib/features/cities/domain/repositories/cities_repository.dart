import 'package:ibiapabaapp/shared/models/city.dart';

abstract class CitiesRepository {
  Future<List<City>> getAllCities({bool forceRefresh = false});
  Future<City?> getCityById(String id);
}
