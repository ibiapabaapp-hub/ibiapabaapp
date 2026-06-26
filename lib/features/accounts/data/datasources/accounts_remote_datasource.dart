import 'package:ibiapabaapp/shared/models/account.dart';
import 'package:ibiapabaapp/features/accounts/domain/entities/account_interests.dart';
import 'package:ibiapabaapp/features/accounts/domain/entities/account_interests_response.dart';

abstract class AccountsRemoteDatasource {
  Future<AccountInterests> getAccountInterests(String accountId);

  Future<AccountInterestsResponse> updateAccountInterests({
    required String accountId,
    required AccountInterests interests,
  });

  Future<Account> updateAccount({
    required String accountId,
    required Map<String, dynamic> updates,
  });

  Future<void> removeAccount(String accountId);
}
