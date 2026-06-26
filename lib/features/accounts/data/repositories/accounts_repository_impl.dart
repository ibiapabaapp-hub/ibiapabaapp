import 'package:dartz/dartz.dart';
import 'package:ibiapabaapp/core/errors/failures/failures.dart';
import 'package:ibiapabaapp/core/logger/handlers/repository_log_handler.dart';
import 'package:ibiapabaapp/core/logger/log_tags.dart';
import 'package:ibiapabaapp/features/accounts/data/datasources/accounts_local_storage.dart';
import 'package:ibiapabaapp/features/accounts/data/datasources/accounts_remote_datasource.dart';
import 'package:ibiapabaapp/features/auth/data/mappers/auth_exception_to_failure_mapper.dart';
import 'package:ibiapabaapp/shared/models/account.dart';
import 'package:ibiapabaapp/features/accounts/domain/entities/account_interests.dart';
import 'package:ibiapabaapp/features/accounts/domain/entities/account_interests_response.dart';
import 'package:ibiapabaapp/features/accounts/domain/repositories/accounts_repository.dart';
import 'package:ibiapabaapp/features/accounts/domain/tags/accounts_logtags.dart';
import 'package:logger/logger.dart';

class AccountsRepositoryImpl
    with RepositoryLogHandler
    implements AccountsRepository {
  @override
  final Logger logger;
  final AccountsRemoteDatasource remoteDatasource;
  final AccountsLocalStorage localStorage;

  AccountsRepositoryImpl({
    required this.remoteDatasource,
    required this.localStorage,
    required this.logger,
  });

  @override
  LogFeature get feature => LogFeature.accounts;

  @override
  AppFailure Function(Object) get featureMapper =>
      AuthExceptionToFailureMapper.map;

  @override
  Future<Either<AppFailure, List<Account>>> getCachedAccounts() async {
    try {
      final cached = await localStorage.getCachedAccounts();
      return Right(cached);
    } catch (e, stack) {
      return Left(
        handleRepositoryError(
          exception: e,
          stackTrace: stack,
          action: AccountsAction.getCachedAccounts,
        ),
      );
    }
  }

  @override
  Future<Either<AppFailure, void>> addCachedAccount(Account account) async {
    try {
      await localStorage.addCachedAccount(account);
      return const Right(null);
    } catch (e, stack) {
      return Left(
        handleRepositoryError(
          exception: e,
          stackTrace: stack,
          action: AccountsAction.addCachedAccount,
        ),
      );
    }
  }

  @override
  Future<Either<AppFailure, void>> removeCachedAccount(String accountId) async {
    try {
      await localStorage.removeCachedAccount(accountId);
      return const Right(null);
    } catch (e, stack) {
      return Left(
        handleRepositoryError(
          exception: e,
          stackTrace: stack,
          action: AccountsAction.removeCachedAccount,
        ),
      );
    }
  }

  @override
  Future<Either<AppFailure, void>> removeAccount(String accountId) async {
    try {
      await remoteDatasource.removeAccount(accountId);
      await localStorage.removeCachedAccount(accountId);

      return const Right(null);
    } catch (e, stack) {
      return Left(
        handleRepositoryError(
          exception: e,
          stackTrace: stack,
          action: AccountsAction.removeAccount,
        ),
      );
    }
  }

  @override
  Future<Either<AppFailure, Account>> updateAccount({
    required String accountId,
    required Map<String, dynamic> updates,
  }) async {
    try {
      final result = await remoteDatasource.updateAccount(
        accountId: accountId,
        updates: updates,
      );
      await localStorage.addCachedAccount(result);

      return Right(result);
    } catch (e, stack) {
      return Left(
        handleRepositoryError(
          exception: e,
          stackTrace: stack,
          action: AccountsAction.updateAccount,
        ),
      );
    }
  }

  @override
  Future<Either<AppFailure, AccountInterests>> getAccountInterests(
    String accountId,
  ) async {
    try {
      final result = await remoteDatasource.getAccountInterests(accountId);
      return Right(result);
    } catch (e, stack) {
      return Left(
        handleRepositoryError(
          exception: e,
          stackTrace: stack,
          action: AccountsAction.getAccountInterests,
        ),
      );
    }
  }

  @override
  Future<Either<AppFailure, AccountInterestsResponse>> updateAccountInterests({
    required String accountId,
    required AccountInterests interests,
  }) async {
    try {
      final result = await remoteDatasource.updateAccountInterests(
        accountId: accountId,
        interests: interests,
      );
      return Right(result);
    } catch (e, stack) {
      return Left(
        handleRepositoryError(
          exception: e,
          stackTrace: stack,
          action: AccountsAction.updateAccountInterests,
        ),
      );
    }
  }

  @override
  Future<Either<AppFailure, void>> saveActiveAccountId(String accountId) async {
    try {
      await localStorage.saveActiveAccountId(accountId);
      return const Right(null);
    } catch (e, stack) {
      return Left(
        handleRepositoryError(
          exception: e,
          stackTrace: stack,
          action: AccountsAction.saveActiveAccountId,
        ),
      );
    }
  }

  @override
  Future<Either<AppFailure, String?>> getActiveAccountId() async {
    try {
      final result = await localStorage.getActiveAccountId();
      return Right(result);
    } catch (e, stack) {
      return Left(
        handleRepositoryError(
          exception: e,
          stackTrace: stack,
          action: AccountsAction.getActiveAccountId,
        ),
      );
    }
  }

  @override
  Future<Either<AppFailure, void>> clearActiveAccountId() async {
    try {
      await localStorage.clearActiveAccountId();
      return const Right(null);
    } catch (e, stack) {
      return Left(
        handleRepositoryError(
          exception: e,
          stackTrace: stack,
          action: AccountsAction.clearActiveAccountId,
        ),
      );
    }
  }
}
