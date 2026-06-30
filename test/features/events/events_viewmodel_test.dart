import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ibivibe/core/logger/logger.dart';
import 'package:ibivibe/features/events/viewmodels/events_viewmodel.dart';
import 'package:ibivibe/features/events/providers/events_providers.dart';
import 'package:ibivibe/shared/models/account.dart';
import 'package:ibivibe/shared/models/account_type.dart';
import 'package:ibivibe/shared/models/business.dart';
import 'package:ibivibe/shared/models/event.dart';
import 'package:ibivibe/shared/providers/accounts_viewmodel.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/mocks.dart';

void main() {
  late MockEventsRepository mockRepo;
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

  final testEvent = Event(
    id: 'e1',
    slug: 'event-1',
    name: 'Event 1',
    ownerAccountId: 'acc1',
    type: EventType.simple,
    reachLevel: ReachLevel.local,
    categories: ['cat1'],
    startDate: DateTime(2025, 6, 1),
    endDate: DateTime(2025, 6, 2),
    createdAt: DateTime(2025),
    updatedAt: DateTime(2025),
  );

  setUp(() {
    mockRepo = MockEventsRepository();
    mockLogger = MockLogger();
  });

  ProviderContainer createContainer() {
    return ProviderContainer(
      overrides: [
        accountsViewModelProvider.overrideWithValue(
          AccountsData(activeAccount: testAccount),
        ),
        eventsRepositoryProvider.overrideWithValue(mockRepo),
        loggerProvider.overrideWithValue(mockLogger),
      ],
    );
  }

  group('events controller', () {
    test('build returns empty list when no active account', () async {
      final container = ProviderContainer(
        overrides: [
          accountsViewModelProvider.overrideWithValue(const AccountsData()),
          eventsRepositoryProvider.overrideWithValue(mockRepo),
          loggerProvider.overrideWithValue(mockLogger),
        ],
      );

      final state = await container.read(eventsViewModelProvider.future);
      expect(state, isEmpty);

      container.dispose();
    });

    test('build fetches events when active account exists', () async {
      when(() => mockRepo.getAllEvents())
          .thenAnswer((_) async => [testEvent]);

      final container = createContainer();
      final state = await container.read(eventsViewModelProvider.future);

      expect(state.length, 1);
      expect(state.first.id, 'e1');
      verify(() => mockRepo.getAllEvents()).called(1);

      container.dispose();
    });

    test('getAllEvents updates state with events', () async {
      when(() => mockRepo.getAllEvents())
          .thenAnswer((_) async => [testEvent]);

      final container = createContainer();
      await container.read(eventsViewModelProvider.future);

      final notifier = container.read(eventsViewModelProvider.notifier);
      await notifier.getAllEvents();

      final state = container.read(eventsViewModelProvider);
      expect(state.value, contains(testEvent));

      container.dispose();
    });

    test('getAllEvents calls repository', () async {
      when(() => mockRepo.getAllEvents())
          .thenAnswer((_) async => []);

      final container = createContainer();
      await container.read(eventsViewModelProvider.future);

      final notifier = container.read(eventsViewModelProvider.notifier);
      await notifier.getAllEvents();

      verify(() => mockRepo.getAllEvents()).called(greaterThanOrEqualTo(1));

      container.dispose();
    });

    test('refresh calls getAllEvents', () async {
      when(() => mockRepo.getAllEvents())
          .thenAnswer((_) async => [testEvent]);

      final container = createContainer();
      await container.read(eventsViewModelProvider.future);

      final notifier = container.read(eventsViewModelProvider.notifier);
      await notifier.refresh();

      verify(() => mockRepo.getAllEvents()).called(greaterThanOrEqualTo(1));

      container.dispose();
    });
  });
}
