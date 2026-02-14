import 'package:dio/dio.dart';
import 'package:ibiapabaapp/core/network/dio_client.dart';
import 'package:ibiapabaapp/core/network/dio_error_to_exception_mapper.dart';
import 'package:ibiapabaapp/features/auth/data/parsers/auth_response_parser.dart';
import 'package:ibiapabaapp/features/auth/data/parsers/check_availability_parser.dart';
import 'package:ibiapabaapp/features/auth/domain/entities/auth_result.dart';
import 'package:ibiapabaapp/features/auth/domain/entities/check_availability.dart';
import 'package:ibiapabaapp/features/auth/domain/entities/register_form_data.dart';

abstract class AuthRemoteDatasource {
  Future<AuthResult> login({required String email, required String password});

  Future<AuthResult> register({required RegisterFormData registerFormData});

  Future<CheckAvailability> checkAvailability({
    required String field,
    required String value,
  });
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final Dio dio = DioClient.instance;

  @override
  Future<AuthResult> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        '/auth/login',
        data: {'email': email, 'password': password},
      );
      return AuthResponseParser.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw e.mapDioExceptionToAppException();
    }
  }

  @override
  Future<AuthResult> register({
    required RegisterFormData registerFormData,
  }) async {
    try {
      final response = await dio.post(
        '/auth/register',
        data: registerFormData.toJson(),
      );
      return AuthResponseParser.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw e.mapDioExceptionToAppException();
    }
  }

  @override
  Future<CheckAvailability> checkAvailability({
    required String field,
    required String value,
  }) async {
    try {
      final response = await dio.get(
        '/auth/check-unique',
        queryParameters: {'field': field, 'value': value},
      );
      return CheckAvailabilityParser.fromJson(response.data);
    } on DioException catch (e) {
      throw e.mapDioExceptionToAppException();
    }
  }
}
