import 'package:ibivibe/shared/models/account.dart';
import 'package:ibivibe/features/accounts/models/account_interests.dart';
import 'package:ibivibe/features/accounts/models/account_interests_response.dart';

abstract class AccountsRepository {
  Future<List<Account>> getCachedAccounts();

  Future<void> addCachedAccount(Account account);

  Future<void> removeCachedAccount(String accountId);

  Future<void> removeAccount(String accountId);

  Future<Account> updateAccount({
    required String accountId,
    required Map<String, dynamic> updates,
  });

  Future<AccountInterests> getAccountInterests(String accountId);

  Future<AccountInterestsResponse> updateAccountInterests({
    required String accountId,
    required AccountInterests interests,
  });

  Future<void> saveActiveAccountId(String accountId);
  Future<String?> getActiveAccountId();
  Future<void> clearActiveAccountId();
}
