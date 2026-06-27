import 'package:flutter/material.dart';
import 'package:ibivibe/core/logger/handlers/controller_log_handler.dart';
import 'package:ibivibe/core/logger/log_tags.dart';
import 'package:ibivibe/core/logger/logger.dart';
import 'package:ibivibe/core/preferences/preferences_logtags.dart';
import 'package:ibivibe/core/preferences/user_preferences_providers.dart';
import 'package:ibivibe/core/preferences/user_preferences_storage.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_preferences_state_provider.g.dart';

@Riverpod(keepAlive: true)
class UserPreferencesState extends _$UserPreferencesState
    with ControllerLogHandler {
  @override
  late final Logger logger = ref.read(loggerProvider);

  @override
  LogFeature get feature => LogFeature.preferences;

  @override
  UserPreferences build() => const UserPreferences();

  UserPreferencesStorage get _storage =>
      ref.read(userPreferencesStorageProvider);

  Future<void> restore() async {
    try {
      final needsOnboarding = await _storage.getNeedsOnboarding();
      final favoriteThemeMode = await _storage.getFavoriteThemeMode();

      if (!ref.mounted) return;

      state = state.copyWith(
        needsOnboarding: needsOnboarding,
        themeMode: favoriteThemeMode,
      );
    } catch (e) {
      logControllerError(action: PreferencesActions.restore, failure: e);
    }
  }

  Future<void> setNeedsOnboarding(bool value) async {
    await _storage.setNeedsOnboarding(value);
    state = state.copyWith(needsOnboarding: value);
    logControllerSuccess(action: PreferencesActions.setNeedsOnboarding);
  }

  Future<void> setFavoriteThemeMode(ThemeMode mode) async {
    await _storage.saveFavoriteThemeMode(mode);
    state = state.copyWith(themeMode: mode);
    logControllerSuccess(action: PreferencesActions.setFavoriteThemeMode);
  }

  Future<ThemeMode> getFavoriteThemeMode() async {
    return _storage.getFavoriteThemeMode();
  }
}

class UserPreferences {
  final ThemeMode themeMode;
  final bool needsOnboarding;

  const UserPreferences({
    this.themeMode = ThemeMode.system,
    this.needsOnboarding = true,
  });

  UserPreferences copyWith({ThemeMode? themeMode, bool? needsOnboarding}) {
    return UserPreferences(
      themeMode: themeMode ?? this.themeMode,
      needsOnboarding: needsOnboarding ?? this.needsOnboarding,
    );
  }
}
