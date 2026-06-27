import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ibivibe/core/logger/logger.dart';
import 'package:ibivibe/features/businesses/presentation/controllers/businesses_controller.dart';
import 'package:ibivibe/features/businesses/presentation/providers/businesses_providers.dart';
import 'package:ibivibe/shared/models/account.dart';
import 'package:ibivibe/shared/models/account_type.dart';
import 'package:ibivibe/shared/models/business.dart';
import 'package:ibivibe/shared/providers/accounts_state_provider.dart';
import 'package:logger/logger.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks/mocks.dart';

void main() {
  late MockBusinessesRepository mockRepo;
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

  final testBusiness = Business(
    id: 'b1',
    name: 'Business 1',
    slug: 'business-1',
    maxReachLevel: ReachLevel.local,
    categories: ['cat1'],
    createdAt: DateTime(2025),
  );

  setUp(() {
    mockRepo = MockBusinessesRepository();
    mockLogger = MockLogger();
  });

  ProviderContainer createContainer() {
    return ProviderContainer(
      overrides: [
        accountsStateProvider.overrideWithValue(
          AccountsData(activeAccount: testAccount),
        ),
        businessesRepositoryProvider.overrideWithValue(mockRepo),
        loggerProvider.overrideWithValue(mockLogger),
      ],
    );
  }

  group('businesses controller', () {
    test('build returns empty list when no active account', () async {
      final container = ProviderContainer(
        overrides: [
          accountsStateProvider.overrideWithValue(const AccountsData()),
          businessesRepositoryProvider.overrideWithValue(mockRepo),
          loggerProvider.overrideWithValue(mockLogger),
        ],
      );

      final state = await container.read(businessesProvider.future);
      expect(state, isEmpty);

      container.dispose();
    });

    test('build fetches businesses when active account exists', () async {
      when(() => mockRepo.getAllBusinesses())
          .thenAnswer((_) async => [testBusiness]);

      final container = createContainer();
      final state = await container.read(businessesProvider.future);

      expect(state.length, 1);
      expect(state.first.id, 'b1');
      verify(() => mockRepo.getAllBusinesses()).called(1);

      container.dispose();
    });

    test('getAllBusinesses updates state with businesses', () async {
      when(() => mockRepo.getAllBusinesses())
          .thenAnswer((_) async => [testBusiness]);

      final container = createContainer();
      await container.read(businessesProvider.future);

      final notifier = container.read(businessesProvider.notifier);
      await notifier.getAllBusinesses();

      final state = container.read(businessesProvider);
      expect(state.value, contains(testBusiness));

      container.dispose();
    });

    test('getAllBusinesses calls repository', () async {
      when(() => mockRepo.getAllBusinesses())
          .thenAnswer((_) async => []);

      final container = createContainer();
      await container.read(businessesProvider.future);

      final notifier = container.read(businessesProvider.notifier);
      await notifier.getAllBusinesses();

      verify(() => mockRepo.getAllBusinesses()).called(greaterThanOrEqualTo(1));

      container.dispose();
    });

    test('refresh calls getAllBusinesses', () async {
      when(() => mockRepo.getAllBusinesses())
          .thenAnswer((_) async => [testBusiness]);

      final container = createContainer();
      await container.read(businessesProvider.future);

      final notifier = container.read(businessesProvider.notifier);
      await notifier.refresh();

      verify(() => mockRepo.getAllBusinesses()).called(greaterThanOrEqualTo(1));

      container.dispose();
    });
  });
}
