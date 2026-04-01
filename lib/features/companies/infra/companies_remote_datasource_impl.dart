import 'package:dio/dio.dart';
import 'package:ibiapabaapp/core/network/dio_exception_to_app_exception_mapper.dart';
import 'package:ibiapabaapp/features/companies/data/datasource/companies_remote_datasource.dart';
import 'package:ibiapabaapp/features/companies/infra/models/company_model.dart';
import 'package:ibiapabaapp/features/companies/domain/entities/company.dart';

class CompaniesRemoteDatasourceImpl implements CompaniesRemoteDatasource {
  final Dio dio;
  CompaniesRemoteDatasourceImpl(this.dio);

  @override
  Future<List<Company>> getAllCompanies() async {
    try {
      final response = await dio.get('/companies');
      return CompanyModel.fromJsonList(response.data);
    } on DioException catch (e) {
      throw DioExceptionToAppExceptionMapper.map(e);
    }
  }

  @override
  Future<Company> getCompanyById(String id) async {
    try {
      final response = await dio.get('/companies/$id');
      return CompanyModel.fromJson(response.data);
    } on DioException catch (e) {
      throw DioExceptionToAppExceptionMapper.map(e);
    }
  }
}
