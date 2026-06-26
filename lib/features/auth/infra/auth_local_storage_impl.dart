import 'package:ibiapabaapp/core/cache/base_cache_storage.dart';
import 'package:ibiapabaapp/features/auth/data/datasources/auth_local_storage.dart';
import 'package:ibiapabaapp/shared/models/account.dart';
import 'package:ibiapabaapp/features/accounts/infra/models/account_model.dart';

class AuthLocalStorageImpl extends BaseCacheStorage
    implements AuthLocalStorage {
  AuthLocalStorageImpl(super.cacheService);

  @override
  String get storeName => 'auth';

  @override
  Future<void> saveAccount(Account account) async {
    await saveObject(
      key: 'last_account',
      item: account,
      toMap: AccountModel.toMap,
    );
  }

  @override
  Future<AccountModel?> getCachedAccount() async {
    return await getObject(
      key: 'last_account',
      fromJson: AccountModel.fromJson,
    );
  }

  @override
  Future<void> clearAccount() async {
    await clearKey('last_account');
  }
}
