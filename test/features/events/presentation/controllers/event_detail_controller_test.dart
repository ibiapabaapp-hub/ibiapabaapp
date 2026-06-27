import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ibivibe/core/entities/entity_type.dart';
import 'package:ibivibe/core/logger/logger.dart';
import 'package:ibivibe/features/events/domain/entities/event_detail_data.dart';
import 'package:ibivibe/features/events/presentation/controllers/event_detail_controller.dart';
import 'package:ibivibe/features/events/presentation/providers/events_providers.dart';
import 'package:ibivibe/features/medias/presentation/providers/medias_providers.dart';
import 'package:ibivibe/shared/models/account.dart';
import 'package:ibivibe/shared/models/account_type.dart';
import 'package:ibivibe/shared/models/business.dart';
import 'package:ibivibe/shared/models/event.dart';
import 'package:ibivibe/shared/models/media.dart';
import 'package:ibivibe/shared/providers/accounts_state_provider.dart';
import 'package:logger/logger.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks/mocks.dart';

void main() {
  late MockEventsRepository mockEventsRepo;
  late MockMediasRepository mockMediasRepo;
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

  final testMedia = Media(
    id: 'm1',
    entityType: EntityType.event,
    entityId: 'e1',
    mediaType: MediaType.image,
    url: 'https://example.com/image.jpg',
    isCover: true,
    position: 0,
  );

  setUp(() {
    mockEventsRepo = MockEventsRepository();
    mockMediasRepo = MockMediasRepository();
    mockLogger = MockLogger();
  });

  setUpAll(() {
    registerFallbackValue(EntityType.event);
  });

  ProviderContainer createContainer() {
    return ProviderContainer(
      overrides: [
        accountsStateProvider.overrideWithValue(
          AccountsData(activeAccount: testAccount),
        ),
        eventsRepositoryProvider.overrideWithValue(mockEventsRepo),
        mediasRepositoryProvider.overrideWithValue(mockMediasRepo),
        loggerProvider.overrideWithValue(mockLogger),
      ],
    );
  }

  group('event detail controller', () {
    test('build returns null when no active account', () async {
      final container = ProviderContainer(
        overrides: [
          accountsStateProvider.overrideWithValue(const AccountsData()),
          eventsRepositoryProvider.overrideWithValue(mockEventsRepo),
          mediasRepositoryProvider.overrideWithValue(mockMediasRepo),
          loggerProvider.overrideWithValue(mockLogger),
        ],
      );

      final state = await container.read(eventDetailProvider('e1').future);
      expect(state, isNull);

      container.dispose();
    });

    test('build returns EventDetailData when event exists', () async {
      when(() => mockEventsRepo.getEventById('e1'))
          .thenAnswer((_) async => testEvent);
      when(() => mockMediasRepo.getEntityMedia(
        entityType: any(named: 'entityType'),
        entityId: any(named: 'entityId'),
      )).thenAnswer((_) async => [testMedia]);

      final container = createContainer();
      final state = await container.read(eventDetailProvider('e1').future);

      expect(state, isA<EventDetailData>());
      expect(state!.event.id, 'e1');
      expect(state.media.length, 1);

      container.dispose();
    });

    test('build returns null when event not found', () async {
      when(() => mockEventsRepo.getEventById('999'))
          .thenAnswer((_) async => null);
      when(() => mockMediasRepo.getEntityMedia(
        entityType: any(named: 'entityType'),
        entityId: any(named: 'entityId'),
      )).thenAnswer((_) async => []);

      final container = createContainer();
      final state = await container.read(eventDetailProvider('999').future);

      expect(state, isNull);

      container.dispose();
    });

    test('build handles empty media', () async {
      when(() => mockEventsRepo.getEventById('e1'))
          .thenAnswer((_) async => testEvent);
      when(() => mockMediasRepo.getEntityMedia(
        entityType: any(named: 'entityType'),
        entityId: any(named: 'entityId'),
      )).thenAnswer((_) async => []);

      final container = createContainer();
      final state = await container.read(eventDetailProvider('e1').future);

      expect(state, isA<EventDetailData>());
      expect(state!.media, isEmpty);

      container.dispose();
    });
  });
}
