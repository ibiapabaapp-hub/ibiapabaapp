import 'package:dio/dio.dart';
import 'package:ibiapabaapp/core/network/dio_exception_to_app_exception_mapper.dart';
import 'package:ibiapabaapp/core/storage/token_storage_strategy.dart';
import 'package:ibiapabaapp/shared/models/account.dart';
import 'package:ibiapabaapp/features/auth/domain/entities/auth_result.dart';
import 'package:ibiapabaapp/features/auth/domain/entities/check_availability.dart';
import 'package:ibiapabaapp/features/auth/domain/entities/complete_google_registration.dart';
import 'package:ibiapabaapp/features/auth/domain/entities/google_auth_result.dart';
import 'package:ibiapabaapp/features/auth/domain/entities/register_form_data.dart';
import 'package:ibiapabaapp/features/auth/domain/repositories/auth_repository.dart';
import 'package:ibiapabaapp/shared/models/account_type.dart';
import 'package:ibiapabaapp/shared/models/gender.dart';
import 'package:ibiapabaapp/features/accounts/infra/models/account_model.dart';
import 'package:ibiapabaapp/features/auth/infra/models/auth_result_model.dart';
import 'package:ibiapabaapp/features/auth/infra/models/check_availability_model.dart';
import 'package:ibiapabaapp/features/auth/infra/models/complete_google_registration_response_model.dart';
import 'package:ibiapabaapp/features/auth/infra/models/google_auth_result_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final Dio _dio;
  final TokenStorageStrategy _storage;

  AuthRepositoryImpl(this._dio, this._storage);

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
    required AvailabilityField field,
    required String value,
  }) async {
    try {
      final response = await _dio.get(
        '/auth/check-unique',
        queryParameters: {'field': field.value, 'value': value},
      );
      return CheckAvailabilityModel.fromJson(response.data);
    } on DioException catch (e) {
      throw DioExceptionToAppExceptionMapper.map(e);
    }
  }

  @override
  Future<Account> getMe() async {
    try {
      final response = await _dio.get('/auth/me');
      return AccountModel.fromJson(response.data);
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

  @override
  Future<GoogleAuthResult> loginWithGoogle({required String idToken}) async {
    try {
      final response = await _dio.post(
        '/auth/google',
        data: {'id_token': idToken},
      );
      return GoogleAuthResultModel.fromJson(response.data).toEntity();
    } on DioException catch (e) {
      throw DioExceptionToAppExceptionMapper.map(e);
    }
  }

  @override
  Future<CompleteGoogleRegistrationResponse> completeGoogleRegistration({
    required String tempToken,
    required String slug,
    required AccountType type,
    Gender? gender,
  }) async {
    try {
      final response = await _dio.post(
        '/auth/google/complete',
        data: {
          'temp_token': tempToken,
          'slug': slug,
          'type': type.value,
          'gender': gender?.value,
        },
      );
      return CompleteGoogleRegistrationResponseModel.fromJson(
        response.data,
      ).toEntity();
    } on DioException catch (e) {
      throw DioExceptionToAppExceptionMapper.map(e);
    }
  }
}
