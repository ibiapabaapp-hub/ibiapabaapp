import 'package:ibivibe/core/cache/base_cache_storage.dart';
import 'package:ibivibe/features/accounts/accounts_local_storage.dart';
import 'package:ibivibe/shared/models/account.dart';
import 'package:ibivibe/features/accounts/models/account_model.dart';

class AccountsLocalStorageImpl extends BaseCacheStorage
    implements AccountsLocalStorage {
  AccountsLocalStorageImpl(super.cacheService);

  @override
  String get storeName => 'accounts';

  @override
  Future<void> saveCachedAccounts(List<Account> accounts) async {
    await saveList(
      key: 'cached_accounts',
      items: accounts,
      toMap: (account) => AccountModel.toMap(account),
    );
  }

  @override
  Future<List<Account>> getCachedAccounts() async {
    return await getList(
      key: 'cached_accounts',
      fromJson: (json) => AccountModel.fromJson(json),
    );
  }

  @override
  Future<void> addCachedAccount(Account account) async {
    final cached = await getCachedAccounts();
    final filtered = cached.where((a) => a.id != account.id).toList();
    filtered.add(account);
    
    await saveCachedAccounts(filtered);
  }

  @override
  Future<void> removeCachedAccount(String accountId) async {
    final cached = await getCachedAccounts();
    final filtered = cached.where((a) => a.id != accountId).toList();
    await saveCachedAccounts(filtered);
  }

  @override
  Future<void> saveActiveAccountId(String accountId) async {
    await saveObject(
      key: 'active_account_id',
      item: accountId,
      toMap: (id) => {'id': id},
    );
  }

  @override
  Future<String?> getActiveAccountId() async {
    try {
      final data = await getObject(
        key: 'active_account_id',
        fromJson: (json) => json,
      );
      return data?['id'] as String?;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> clearActiveAccountId() async {
    await clearKey('active_account_id');
  }
}
