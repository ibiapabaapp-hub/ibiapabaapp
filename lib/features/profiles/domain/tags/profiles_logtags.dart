import 'package:ibiapabaapp/core/logger/log_tags.dart';

enum ProfileAction implements LogTag {
  getAccountProfiles('[GET_ACCOUNT_PROFILES]'),
  getProfileInterests('[GET_PROFILE_INTERESTS]'),
  updateProfileInterests('[UPDATE_PROFILE_INTERESTS]'),
  restore('[RESTORE]');

  @override
  final String tag;
  const ProfileAction(this.tag);
}