import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ibiapabaapp/core/logger/logger.dart';
import 'package:ibiapabaapp/features/accounts/domain/entities/account_interests.dart';
import 'package:ibiapabaapp/features/accounts/domain/entities/account_interests_response.dart';
import 'package:ibiapabaapp/features/accounts/domain/repositories/accounts_repository.dart';
import 'package:ibiapabaapp/features/accounts/presentation/controllers/account_interests_controller.dart';
import 'package:ibiapabaapp/features/accounts/presentation/providers/accounts_providers.dart';
import 'package:ibiapabaapp/shared/models/account.dart';
import 'package:ibiapabaapp/shared/models/account_type.dart';
import 'package:ibiapabaapp/shared/providers/accounts_state_provider.dart';
import 'package:logger/logger.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks/mocks.dart';

void main() {
  late MockAccountsRepository mockRepo;
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

  setUp(() {
    mockRepo = MockAccountsRepository();
    mockLogger = MockLogger();
  });

  setUpAll(() {
    registerFallbackValue(
      AccountInterests(businesses: [], events: []),
    );
  });

  ProviderContainer createContainer({Account? account}) {
    return ProviderContainer(
      overrides: [
        accountsStateProvider.overrideWithValue(
          AccountsData(activeAccount: account),
        ),
        accountsRepositoryProvider.overrideWithValue(mockRepo),
        loggerProvider.overrideWithValue(mockLogger),
      ],
    );
  }

  group('account interests controller', () {
    test('build returns initial state with empty interests', () {
      final container = createContainer(account: testAccount);

      final state = container.read(accountInterestsControllerProvider);

      expect(state.status, AccountInterestsStatus.initial);
      expect(state.interestsData.businesses, isEmpty);
      expect(state.interestsData.events, isEmpty);

      container.dispose();
    });

    test('submitInterests returns null when no active account', () async {
      final container = createContainer(account: null);

      final notifier =
          container.read(accountInterestsControllerProvider.notifier);
      final result = await notifier.submitInterests();

      expect(result, isNull);

      container.dispose();
    });

    test('submitInterests returns response on success', () async {
      when(() => mockRepo.updateAccountInterests(
        accountId: any(named: 'accountId'),
        interests: any(named: 'interests'),
      )).thenAnswer((_) async =>
          AccountInterestsResponse(count: 2));

      final container = createContainer(account: testAccount);

      final notifier =
          container.read(accountInterestsControllerProvider.notifier);
      final result = await notifier.submitInterests();

      expect(result, isNotNull);
      expect(result!.count, 2);

      final state = container.read(accountInterestsControllerProvider);
      expect(state.status, AccountInterestsStatus.completed);

      container.dispose();
    });

    test('submitInterests sets error state on failure', () async {
      when(() => mockRepo.updateAccountInterests(
        accountId: any(named: 'accountId'),
        interests: any(named: 'interests'),
      )).thenThrow(Exception('network error'));

      final container = createContainer(account: testAccount);

      final notifier =
          container.read(accountInterestsControllerProvider.notifier);
      final result = await notifier.submitInterests();

      expect(result, isNull);

      final state = container.read(accountInterestsControllerProvider);
      expect(state.status, AccountInterestsStatus.error);

      container.dispose();
    });
  });
}
