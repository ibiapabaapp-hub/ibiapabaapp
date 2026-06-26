import 'package:flutter/material.dart';
import 'package:ibiapabaapp/shared/models/account.dart';
import 'package:ibiapabaapp/shared/models/city.dart';
import 'package:latlong2/latlong.dart';

class AppSession {
  final City? currentCity;
  final LatLng? devicePosition;
  final List<String> recentSearches;

  final ThemeMode themeMode;
  final bool needsOnboarding;

  const AppSession({
    this.currentCity,
    this.devicePosition,
    this.recentSearches = const [],
    this.themeMode = ThemeMode.system,
    this.needsOnboarding = true,
  });

  AppSession copyWith({
    Account? activeAccount,
    bool clearActiveAccount = false,
    List<Account>? cachedAccounts,
    City? currentCity,
    bool clearCity = false,
    LatLng? devicePosition,
    bool clearDevicePosition = false,
    List<String>? recentSearches,
    ThemeMode? themeMode,
    bool? needsOnboarding,
  }) {
    return AppSession(
      currentCity: clearCity ? null : (currentCity ?? this.currentCity),
      devicePosition: clearDevicePosition
          ? null
          : (devicePosition ?? this.devicePosition),
      recentSearches: recentSearches ?? this.recentSearches,
      themeMode: themeMode ?? this.themeMode,
      needsOnboarding: needsOnboarding ?? this.needsOnboarding,
    );
  }
}
