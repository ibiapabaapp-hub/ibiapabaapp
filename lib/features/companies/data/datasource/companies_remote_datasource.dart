import 'package:dio/dio.dart';
import 'package:ibiapabaapp/core/network/dio_error_to_exception_mapper.dart';
import 'package:ibiapabaapp/features/companies/data/parsers/company_parser.dart';
import 'package:ibiapabaapp/features/companies/domain/entities/company.dart';

abstract class CompaniesRemoteDatasource {
  Future<List<Company>> getAllCompanies();
  Future<Company> getCompanyById(String id);
}

class CompaniesRemoteDatasourceImpl implements CompaniesRemoteDatasource {
  final Dio dio;
  CompaniesRemoteDatasourceImpl(this.dio);

  @override
  Future<List<Company>> getAllCompanies() async {
    try {
      final response = await dio.get('/companies');
      return CompanyParser.fromJsonList(response.data);
    } on DioException catch (e) {
      throw DioErrorToExceptionMapper.map(e);
    }
  }

  @override
  Future<Company> getCompanyById(String id) async {
    try {
      final response = await dio.get('/companies/$id');
      return CompanyParser.fromJson(response.data);
    } on DioException catch (e) {
      throw DioErrorToExceptionMapper.map(e);
    }
  }
}
