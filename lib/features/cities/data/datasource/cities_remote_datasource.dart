import 'package:ibiapabaapp/shared/models/city.dart';

abstract class CitiesRemoteDatasource {
  Future<List<City>> getAllCities();
}
