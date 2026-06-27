import 'package:ibiapabaapp/shared/models/account.dart';

abstract class AccountsLocalStorage {
  Future<void> saveCachedAccounts(List<Account> accounts);
  Future<List<Account>> getCachedAccounts();
  Future<void> addCachedAccount(Account account);
  Future<void> removeCachedAccount(String accountId);
  Future<void> saveActiveAccountId(String accountId);
  Future<String?> getActiveAccountId();
  Future<void> clearActiveAccountId();
}
