import 'package:dio/dio.dart';
import 'package:ibiapabaapp/core/network/dio_exception_to_app_exception_mapper.dart';
import 'package:ibiapabaapp/core/storage/token_storage_strategy.dart';
import 'package:ibiapabaapp/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:ibiapabaapp/features/auth/domain/entities/auth_result.dart';
import 'package:ibiapabaapp/features/auth/domain/entities/check_availability.dart';
import 'package:ibiapabaapp/features/auth/domain/entities/register_form_data.dart';
import 'package:ibiapabaapp/features/auth/domain/entities/user.dart';
import 'package:ibiapabaapp/features/auth/infra/models/auth_result_model.dart';
import 'package:ibiapabaapp/features/auth/infra/models/check_availability_model.dart';
import 'package:ibiapabaapp/features/auth/infra/models/user_model.dart';

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final Dio _dio;
  final TokenStorageStrategy _storage;

  AuthRemoteDatasourceImpl(this._dio, TokenStorageStrategy storage)
    : _storage = storage;

  @override
  Future<AuthResult> login({
    required String email,
    required String password,
    }) async {
      try {
        final response = await _dio.post(
          '/auth/login',
          data: {'email': email, 'password': password},
        );
        return AuthResultModel.fromJson(response.data);
      } on DioException catch (e) {
        throw DioExceptionToAppExceptionMapper.map(e);
    }
  }

  @override
  Future<AuthResult> register({
    required RegisterFormData registerFormData,
  }) async {
    try {
      final response = await _dio.post(
        '/auth/register',
        data: registerFormData.toJson(),
      );
      return AuthResultModel.fromJson(response.data);
    } on DioException catch (e) {
      throw DioExceptionToAppExceptionMapper.map(e);
    }
  }

  @override
  Future<CheckAvailability> checkAvailability({
    required String field,
    required String value,
  }) async {
    try {
      final response = await _dio.get(
        '/auth/check-unique',
        queryParameters: {'field': field, 'value': value},
      );
      return CheckAvailabilityModel.fromJson(response.data);
    } on DioException catch (e) {
      throw DioExceptionToAppExceptionMapper.map(e);
    }
  }

  @override
  Future<User> getMe() async {
    try {
      final response = await _dio.get('/auth/me');
      return UserModel.fromJson(response.data);
    } on DioException catch (e) {
      throw DioExceptionToAppExceptionMapper.map(e);
    }
  }

  @override
  Future<AuthResult> refreshTokens() async {
    try {
      final refreshToken = await _storage.getRefreshToken();
      final response = await _dio.post(
        '/auth/refresh',
        options: Options(headers: {'x-refresh-token': refreshToken}),
      );

      return AuthResultModel.fromJson(response.data);
    } on DioException catch (e) {
      throw DioExceptionToAppExceptionMapper.map(e);
    }
  }
}
