import 'package:dio/dio.dart';
import 'package:ibiapabaapp/core/network/dio_error_to_exception_mapper.dart';
import 'package:ibiapabaapp/features/cities/data/parsers/city_parser.dart';
import 'package:ibiapabaapp/features/cities/domain/entities/city.dart';

abstract class CitiesRemoteDatasource {
  Future<List<City>> getAllCities();
}

class CitiesRemoteDatasourceImpl implements CitiesRemoteDatasource {
  final Dio _dio;
  CitiesRemoteDatasourceImpl(this._dio);

  @override
  Future<List<City>> getAllCities() async {
    try {
      final response = await _dio.get('/cities');
      final List<City> cities = CityParser.fromJsonList(response.data);

      return cities;
    } on DioException catch (e) {
      throw DioErrorToExceptionMapper.map(e);
    }
  }
}
