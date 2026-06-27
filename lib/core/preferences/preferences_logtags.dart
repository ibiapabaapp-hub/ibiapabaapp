import 'package:ibivibe/core/logger/log_tags.dart';

enum PreferencesActions implements LogTag {
  restore('[RESTORE]'),
  setFavoriteThemeMode('[SET_FAVORITE_THEME_MODE]'),
  setNeedsOnboarding('[SET_NEEDS_ONBOARDING]');

  @override
  final String tag;
  const PreferencesActions(this.tag);
}
