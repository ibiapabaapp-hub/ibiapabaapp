import 'package:dio/dio.dart';
import 'package:ibiapabaapp/core/network/dio_exception_to_app_exception_mapper.dart';
import 'package:ibiapabaapp/features/businesses/data/datasource/businesses_remote_datasource.dart';
import 'package:ibiapabaapp/features/businesses/infra/models/business_model.dart';
import 'package:ibiapabaapp/shared/models/business.dart';

class BusinessesRemoteDatasourceImpl implements BusinessesRemoteDatasource {
  final Dio dio;
  BusinessesRemoteDatasourceImpl(this.dio);

  @override
  Future<List<Business>> getAllBusinesses() async {
    try {
      final response = await dio.get('/businesses');
      return BusinessModel.fromJsonList(response.data);
    } on DioException catch (e) {
      throw DioExceptionToAppExceptionMapper.map(e);
    }
  }

  @override
  Future<Business> getBusinessById(String id) async {
    try {
      final response = await dio.get('/businesses/$id');
      return BusinessModel.fromJson(response.data);
    } on DioException catch (e) {
      throw DioExceptionToAppExceptionMapper.map(e);
    }
  }
}
