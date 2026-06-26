import 'package:ibiapabaapp/shared/models/account.dart';
import 'package:ibiapabaapp/features/accounts/infra/models/account_model.dart';

abstract class AuthLocalStorage {
  Future<void> saveAccount(Account account);
  Future<AccountModel?> getCachedAccount();
  Future<void> clearAccount();
}
