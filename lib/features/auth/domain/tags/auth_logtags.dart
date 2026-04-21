import 'package:ibiapabaapp/core/logger/log_tags.dart';

enum AuthAction implements LogTag {
  restore('[RESTORE]'),
  initSession('[INIT_SESSION]'),
  logout('[LOGOUT]'),
  login('[LOGIN_WITH_EMAIL]'),
  register('[REGISTER_WITH_EMAIL]'),
  refreshTokens('[REFRESH_TOKENS]'),
  getMe('[GET_ME]'),
  checkAvailability('[CHECK_AVAILABILITY]'),
  getAccountProfiles('[GET_ACCOUNT_PROFILES]');
  // setUserInterests('[SET_USER_INTERESTS]'),
  // switchProfile('[SWITCH_PROFILE]'),
  // getAccountProfiles('[GET_ACCOUNT_PROFILES]');

  @override
  final String tag;
  const AuthAction(this.tag);
}