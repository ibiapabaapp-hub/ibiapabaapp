import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ibivibe/core/logger/logger.dart';
import 'package:ibivibe/features/cities/cities_viewmodel.dart';
import 'package:ibivibe/features/cities/cities_providers.dart';
import 'package:ibivibe/shared/models/account.dart';
import 'package:ibivibe/shared/models/account_type.dart';
import 'package:ibivibe/shared/models/city.dart';
import 'package:ibivibe/shared/providers/accounts_viewmodel.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks/mocks.dart';

void main() {
  late MockCitiesRepository mockRepo;
  late MockLogger mockLogger;

  final testAccount = Account(
    id: '1',
    email: 'test@test.com',
    name: 'Test',
    active: true,
    isVerified: true,
    createdAt: DateTime(2025),
    updatedAt: DateTime(2025),
    slug: 'test',
    displayName: 'Test',
    type: AccountType.personal,
  );

  final testCity = City(
    id: 'c1',
    name: 'City 1',
    slug: 'city-1',
    categories: ['cat1'],
  );

  setUp(() {
    mockRepo = MockCitiesRepository();
    mockLogger = MockLogger();
  });

  ProviderContainer createContainer() {
    return ProviderContainer(
      overrides: [
        accountsViewModelProvider.overrideWithValue(
          AccountsData(activeAccount: testAccount),
        ),
        citiesRepositoryProvider.overrideWithValue(mockRepo),
        loggerProvider.overrideWithValue(mockLogger),
      ],
    );
  }

  group('cities controller', () {
    test('build returns empty list when no active account', () async {
      final container = ProviderContainer(
        overrides: [
          accountsViewModelProvider.overrideWithValue(const AccountsData()),
          citiesRepositoryProvider.overrideWithValue(mockRepo),
          loggerProvider.overrideWithValue(mockLogger),
        ],
      );

      final state = await container.read(citiesViewModelProvider.future);
      expect(state, isEmpty);

      container.dispose();
    });

    test('build fetches cities when active account exists', () async {
      when(() => mockRepo.getAllCities(forceRefresh: any(named: 'forceRefresh')))
          .thenAnswer((_) async => [testCity]);

      final container = createContainer();
      final state = await container.read(citiesViewModelProvider.future);

      expect(state.length, 1);
      expect(state.first.id, 'c1');
      verify(() => mockRepo.getAllCities(forceRefresh: false)).called(1);

      container.dispose();
    });

    test('getAllCities updates state with cities', () async {
      when(() => mockRepo.getAllCities(forceRefresh: any(named: 'forceRefresh')))
          .thenAnswer((_) async => [testCity]);

      final container = createContainer();
      await container.read(citiesViewModelProvider.future);

      final notifier = container.read(citiesViewModelProvider.notifier);
      await notifier.getAllCities();

      final state = container.read(citiesViewModelProvider);
      expect(state.value, contains(testCity));

      container.dispose();
    });

    test('getAllCities calls repository', () async {
      when(() => mockRepo.getAllCities(forceRefresh: any(named: 'forceRefresh')))
          .thenAnswer((_) async => []);

      final container = createContainer();
      await container.read(citiesViewModelProvider.future);

      final notifier = container.read(citiesViewModelProvider.notifier);
      await notifier.getAllCities();

      verify(() => mockRepo.getAllCities(forceRefresh: false)).called(greaterThanOrEqualTo(1));

      container.dispose();
    });

    test('refresh calls getAllCities with forceRefresh', () async {
      when(() => mockRepo.getAllCities(forceRefresh: any(named: 'forceRefresh')))
          .thenAnswer((_) async => [testCity]);

      final container = createContainer();
      await container.read(citiesViewModelProvider.future);

      final notifier = container.read(citiesViewModelProvider.notifier);
      await notifier.refresh();

      verify(() => mockRepo.getAllCities(forceRefresh: true)).called(greaterThanOrEqualTo(1));

      container.dispose();
    });
  });
}
