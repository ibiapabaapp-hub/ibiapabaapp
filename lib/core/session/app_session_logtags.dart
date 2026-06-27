import 'package:ibivibe/core/logger/log_tags.dart';

enum AppSessionAction implements LogTag {
  restore('[RESTORE]'),
  initSession('[INIT_SESSION]'),
  switchAccount('[SWITCH_ACCOUNT]'),
  loadCachedAccounts('[LOAD_CACHED_ACCOUNTS]'),
  clearAccountFromCache('[CLEAR_ACCOUNT_FROM_CACHE]');

  @override
  final String tag;
  const AppSessionAction(this.tag);
}
