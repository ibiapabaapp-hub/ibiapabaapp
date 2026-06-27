import 'package:ibiapabaapp/core/logger/log_tags.dart';

enum AccountsAction implements LogTag {
  getCachedAccounts('[GET_CACHED_ACCOUNTS]'),
  addCachedAccount('[ADD_CACHED_ACCOUNT]'),
  removeAccount('[REMOVE_ACCOUNT]'),
  removeCachedAccount('[REMOVE_CACHED_ACCOUNT]'),
  updateAccount('[UPDATE_ACCOUNT]'),
  getAccountInterests('[GET_ACCOUNT_INTERESTS]'),
  updateAccountInterests('[UPDATE_ACCOUNT_INTERESTS]'),
  saveActiveAccountId('[SAVE_ACTIVE_ACCOUNT_ID]'),
  switchAccount('[SWITCH_ACCOUNT]'),
  getActiveAccountId('[GET_ACTIVE_ACCOUNT_ID]'),
  clearActiveAccountId('[CLEAR_ACTIVE_ACCOUNT_ID]'),
  loadCachedAccounts('[LOAD_CACHED_ACCOUNTS]'),
  restoreFromCache('[RESTORE_FROM_CACHE]');

  @override
  final String tag;
  const AccountsAction(this.tag);
}
