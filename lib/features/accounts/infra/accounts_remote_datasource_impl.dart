import 'package:dio/dio.dart';
import 'package:ibiapabaapp/core/network/dio_exception_to_app_exception_mapper.dart';
import 'package:ibiapabaapp/features/accounts/data/datasources/accounts_remote_datasource.dart';
import 'package:ibiapabaapp/shared/models/account.dart';
import 'package:ibiapabaapp/features/accounts/domain/entities/account_interests.dart';
import 'package:ibiapabaapp/features/accounts/domain/entities/account_interests_response.dart';
import 'package:ibiapabaapp/features/accounts/infra/models/account_interests_model.dart';
import 'package:ibiapabaapp/features/accounts/infra/models/account_interests_response_model.dart';
import 'package:ibiapabaapp/features/accounts/infra/models/account_model.dart';

class AccountsRemoteDatasourceImpl implements AccountsRemoteDatasource {
  final Dio _dio;

  AccountsRemoteDatasourceImpl(this._dio);

  @override
  Future<AccountInterests> getAccountInterests(String accountId) async {
    try {
      final response = await _dio.get('/accounts/$accountId/interests');
      final model = AccountInterestsModel.fromJson(response.data);
      return AccountInterestsModel.toEntity(model);
    } on DioException catch (e) {
      throw DioExceptionToAppExceptionMapper.map(e);
    }
  }

  @override
  Future<AccountInterestsResponse> updateAccountInterests({
    required String accountId,
    required AccountInterests interests,
  }) async {
    try {
      final response = await _dio.post(
        '/accounts/$accountId/interests',
        data: AccountInterestsModel.toMap(interests),
      );
      return AccountInterestsResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      throw DioExceptionToAppExceptionMapper.map(e);
    }
  }

  @override
  Future<Account> updateAccount({
    required String accountId,
    required Map<String, dynamic> updates,
  }) async {
    try {
      final response = await _dio.patch('/accounts/$accountId', data: updates);
      return AccountModel.fromJson(response.data);
    } on DioException catch (e) {
      throw DioExceptionToAppExceptionMapper.map(e);
    }
  }

  @override
  Future<void> removeAccount(String accountId) async {
    try {
      await _dio.delete('/accounts/$accountId');
    } on DioException catch (e) {
      throw DioExceptionToAppExceptionMapper.map(e);
    }
  }
}
