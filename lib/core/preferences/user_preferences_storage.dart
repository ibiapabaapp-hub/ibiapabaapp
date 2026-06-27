import 'package:flutter/material.dart';
import 'package:ibivibe/core/cache/base_cache_storage.dart';

class UserPreferencesStorage extends BaseCacheStorage {
  UserPreferencesStorage(super.cacheService);

  @override
  String get storeName => 'user_preferences';

  Future<void> saveFavoriteThemeMode(ThemeMode mode) async {
    saveObject(
      key: 'favorite_theme_mode',
      item: mode,
      toMap: (i) => {'value': i.name},
    );
  }

  Future<ThemeMode> getFavoriteThemeMode() async {
    final result = await getObject(
      key: 'favorite_theme_mode',
      fromJson: (json) => ThemeMode.values.byName(json['value']),
    );
    return result ?? ThemeMode.system;
  }

  Future<void> setNeedsOnboarding(bool value) async {
    saveObject(
      key: 'needs_onboarding',
      item: value,
      toMap: (i) => {'value': i},
    );
  }

  Future<bool> getNeedsOnboarding() async {
    final result = await getObject(
      key: 'needs_onboarding',
      fromJson: (json) => json['value'],
    );
    return result ?? true;
  }
}