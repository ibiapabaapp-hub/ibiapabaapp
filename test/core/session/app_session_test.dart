import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ibiapabaapp/core/session/app_session.dart';
import 'package:ibiapabaapp/shared/models/city.dart';
import 'package:latlong2/latlong.dart';

void main() {
  group('AppSession', () {
    group('constructor defaults', () {
      test('should create session with default values', () {
        final session = AppSession();

        expect(session.currentCity, isNull);
        expect(session.devicePosition, isNull);
        expect(session.recentSearches, isEmpty);
        expect(session.themeMode, ThemeMode.system);
        expect(session.needsOnboarding, isTrue);
      });

      test('should create session with provided values', () {
        final city = City(
          id: '1',
          name: 'São Paulo',
          slug: 'sao-paulo',
          categories: [],
        );
        final position = LatLng(-23.55, -46.63);
        final session = AppSession(
          currentCity: city,
          devicePosition: position,
          recentSearches: ['test'],
          themeMode: ThemeMode.dark,
          needsOnboarding: false,
        );

        expect(session.currentCity, city);
        expect(session.devicePosition, position);
        expect(session.recentSearches, ['test']);
        expect(session.themeMode, ThemeMode.dark);
        expect(session.needsOnboarding, isFalse);
      });
    });

    group('copyWith', () {
      test('should return same values when no arguments provided', () {
        final city = City(
          id: '1',
          name: 'São Paulo',
          slug: 'sao-paulo',
          categories: [],
        );
        final position = LatLng(-23.55, -46.63);
        final session = AppSession(
          currentCity: city,
          devicePosition: position,
          recentSearches: ['a'],
          themeMode: ThemeMode.dark,
          needsOnboarding: false,
        );

        final copied = session.copyWith();

        expect(copied.currentCity, session.currentCity);
        expect(copied.devicePosition, session.devicePosition);
        expect(copied.recentSearches, session.recentSearches);
        expect(copied.themeMode, session.themeMode);
        expect(copied.needsOnboarding, session.needsOnboarding);
      });

      test('should update currentCity', () {
        final session = AppSession();
        final newCity = City(
          id: '2',
          name: 'Recife',
          slug: 'recife',
          categories: [],
        );

        final copied = session.copyWith(currentCity: newCity);

        expect(copied.currentCity, newCity);
      });

      test('should clear currentCity with clearCity flag', () {
        final city = City(
          id: '1',
          name: 'São Paulo',
          slug: 'sao-paulo',
          categories: [],
        );
        final session = AppSession(currentCity: city);

        final copied = session.copyWith(clearCity: true);

        expect(copied.currentCity, isNull);
      });

      test('should update devicePosition', () {
        final session = AppSession();
        final newPos = LatLng(-23.55, -46.63);

        final copied = session.copyWith(devicePosition: newPos);

        expect(copied.devicePosition, newPos);
      });

      test('should clear devicePosition with clearDevicePosition flag', () {
        final session = AppSession(devicePosition: LatLng(0, 0));

        final copied = session.copyWith(clearDevicePosition: true);

        expect(copied.devicePosition, isNull);
      });

      test('should update recentSearches', () {
        final session = AppSession();

        final copied = session.copyWith(recentSearches: ['search1']);

        expect(copied.recentSearches, ['search1']);
      });

      test('should update themeMode', () {
        final session = AppSession();

        final copied = session.copyWith(themeMode: ThemeMode.light);

        expect(copied.themeMode, ThemeMode.light);
      });

      test('should update needsOnboarding', () {
        final session = AppSession();

        final copied = session.copyWith(needsOnboarding: false);

        expect(copied.needsOnboarding, isFalse);
      });

      test('should not mutate original session', () {
        final session = AppSession(
          currentCity: City(
            id: '1',
            name: 'São Paulo',
            slug: 'sao-paulo',
            categories: [],
          ),
          needsOnboarding: true,
        );

        final copied = session.copyWith(needsOnboarding: false);

        expect(session.needsOnboarding, isTrue);
        expect(copied.needsOnboarding, isFalse);
      });
    });
  });
}
