import 'package:dio/dio.dart';
import 'package:ibiapabaapp/core/network/dio_exception_to_app_exception_mapper.dart';
import 'package:ibiapabaapp/features/cities/data/datasource/cities_remote_datasource.dart';
import 'package:ibiapabaapp/shared/models/city.dart';
import 'package:ibiapabaapp/features/cities/infra/models/cities_model.dart';

class CitiesRemoteDatasourceImpl implements CitiesRemoteDatasource {
  final Dio dio;
  CitiesRemoteDatasourceImpl(this.dio);

  @override
  Future<List<City>> getAllCities() async {
    try {
      final response = await dio.get('/cities');
      return CityModel.fromJsonList(response.data);
    } on DioException catch (e) {
      throw DioExceptionToAppExceptionMapper.map(e);
    }
  }
}
