import 'package:ibiapabaapp/features/cities/domain/entities/city.dart';

abstract class CitiesRemoteDatasource {
  Future<List<City>> getAllCities();
}
