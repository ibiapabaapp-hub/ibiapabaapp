import 'package:dio/dio.dart';
import 'package:ibiapabaapp/core/logger/handlers/repository_log_handler.dart';
import 'package:ibiapabaapp/core/logger/log_tags.dart';
import 'package:ibiapabaapp/core/network/dio_exception_to_app_exception_mapper.dart';
import 'package:ibiapabaapp/features/accounts/data/datasources/accounts_local_storage.dart';
import 'package:ibiapabaapp/shared/models/account.dart';
import 'package:ibiapabaapp/features/accounts/domain/entities/account_interests.dart';
import 'package:ibiapabaapp/features/accounts/domain/entities/account_interests_response.dart';
import 'package:ibiapabaapp/features/accounts/domain/repositories/accounts_repository.dart';
import 'package:ibiapabaapp/features/accounts/infra/models/account_interests_model.dart';
import 'package:ibiapabaapp/features/accounts/infra/models/account_interests_response_model.dart';
import 'package:ibiapabaapp/features/accounts/infra/models/account_model.dart';
import 'package:logger/logger.dart';

class AccountsRepositoryImpl
    with RepositoryLogHandler
    implements AccountsRepository {
  @override
  final Logger logger;
  final Dio _dio;
  final AccountsLocalStorage localStorage;

  AccountsRepositoryImpl({
    required Dio dio,
    required this.localStorage,
    required this.logger,
  }) : _dio = dio;

  @override
  LogFeature get feature => LogFeature.accounts;

  @override
  Future<List<Account>> getCachedAccounts() async {
    return localStorage.getCachedAccounts();
  }

  @override
  Future<void> addCachedAccount(Account account) async {
    await localStorage.addCachedAccount(account);
  }

  @override
  Future<void> removeCachedAccount(String accountId) async {
    await localStorage.removeCachedAccount(accountId);
  }

  @override
  Future<void> removeAccount(String accountId) async {
    try {
      await _dio.delete('/accounts/$accountId');
    } on DioException catch (e) {
      throw DioExceptionToAppExceptionMapper.map(e);
    }
    await localStorage.removeCachedAccount(accountId);
  }

  @override
  Future<Account> updateAccount({
    required String accountId,
    required Map<String, dynamic> updates,
  }) async {
    try {
      final response = await _dio.patch(
        '/accounts/$accountId',
        data: updates,
      );
      final result = AccountModel.fromJson(response.data);
      await localStorage.addCachedAccount(result);
      return result;
    } on DioException catch (e) {
      throw DioExceptionToAppExceptionMapper.map(e);
    }
  }

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
  Future<void> saveActiveAccountId(String accountId) async {
    await localStorage.saveActiveAccountId(accountId);
  }

  @override
  Future<String?> getActiveAccountId() async {
    return localStorage.getActiveAccountId();
  }

  @override
  Future<void> clearActiveAccountId() async {
    await localStorage.clearActiveAccountId();
  }
}
