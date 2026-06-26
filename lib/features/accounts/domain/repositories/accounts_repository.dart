import 'package:dartz/dartz.dart';
import 'package:ibiapabaapp/core/errors/failures/failures.dart';
import 'package:ibiapabaapp/shared/models/account.dart';
import 'package:ibiapabaapp/features/accounts/domain/entities/account_interests.dart';
import 'package:ibiapabaapp/features/accounts/domain/entities/account_interests_response.dart';

abstract class AccountsRepository {
  Future<Either<AppFailure, List<Account>>> getCachedAccounts();

  Future<Either<AppFailure, void>> addCachedAccount(Account account);

  Future<Either<AppFailure, void>> removeCachedAccount(String accountId);

  Future<Either<AppFailure, void>> removeAccount(String accountId);

  Future<Either<AppFailure, Account>> updateAccount({
    required String accountId,
    required Map<String, dynamic> updates,
  });

  Future<Either<AppFailure, AccountInterests>> getAccountInterests(
    String accountId,
  );

  Future<Either<AppFailure, AccountInterestsResponse>> updateAccountInterests({
    required String accountId,
    required AccountInterests interests,
  });

  Future<Either<AppFailure, void>> saveActiveAccountId(String accountId);
  Future<Either<AppFailure, String?>> getActiveAccountId();
  Future<Either<AppFailure, void>> clearActiveAccountId();
}
