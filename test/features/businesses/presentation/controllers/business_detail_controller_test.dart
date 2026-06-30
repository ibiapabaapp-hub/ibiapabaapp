import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ibivibe/core/entities/entity_type.dart';
import 'package:ibivibe/core/logger/logger.dart';
import 'package:ibivibe/features/businesses/models/business_detail_data.dart';
import 'package:ibivibe/features/businesses/presentation/controllers/business_detail_controller.dart';
import 'package:ibivibe/features/businesses/presentation/providers/businesses_providers.dart';
import 'package:ibivibe/features/medias/presentation/providers/medias_providers.dart';
import 'package:ibivibe/shared/models/account.dart';
import 'package:ibivibe/shared/models/account_type.dart';
import 'package:ibivibe/shared/models/business.dart';
import 'package:ibivibe/shared/models/media.dart';
import 'package:ibivibe/shared/providers/accounts_state_provider.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks/mocks.dart';

void main() {
  late MockBusinessesRepository mockBusinessesRepo;
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

  final testBusiness = Business(
    id: 'b1',
    name: 'Business 1',
    slug: 'business-1',
    maxReachLevel: ReachLevel.local,
    categories: ['cat1'],
    createdAt: DateTime(2025),
  );

  final testMedia = const Media(
    id: 'm1',
    entityType: EntityType.business,
    entityId: 'b1',
    mediaType: MediaType.image,
    url: 'https://example.com/image.jpg',
    isCover: true,
    position: 0,
  );

  setUp(() {
    mockBusinessesRepo = MockBusinessesRepository();
    mockMediasRepo = MockMediasRepository();
    mockLogger = MockLogger();
  });

  setUpAll(() {
    registerFallbackValue(EntityType.business);
  });

  ProviderContainer createContainer() {
    return ProviderContainer(
      overrides: [
        accountsStateProvider.overrideWithValue(
          AccountsData(activeAccount: testAccount),
        ),
        businessesRepositoryProvider.overrideWithValue(mockBusinessesRepo),
        mediasRepositoryProvider.overrideWithValue(mockMediasRepo),
        loggerProvider.overrideWithValue(mockLogger),
      ],
    );
  }

  group('business detail controller', () {
    test('build returns null when no active account', () async {
      final container = ProviderContainer(
        overrides: [
          accountsStateProvider.overrideWithValue(const AccountsData()),
          businessesRepositoryProvider.overrideWithValue(mockBusinessesRepo),
          mediasRepositoryProvider.overrideWithValue(mockMediasRepo),
          loggerProvider.overrideWithValue(mockLogger),
        ],
      );

      final state =
          await container.read(businessDetailProvider('b1').future);
      expect(state, isNull);

      container.dispose();
    });

    test('build returns BusinessDetailData when business exists', () async {
      when(() => mockBusinessesRepo.getBusinessById('b1'))
          .thenAnswer((_) async => testBusiness);
      when(() => mockMediasRepo.getEntityMedia(
        entityType: any(named: 'entityType'),
        entityId: any(named: 'entityId'),
      )).thenAnswer((_) async => [testMedia]);

      final container = createContainer();
      final state =
          await container.read(businessDetailProvider('b1').future);

      expect(state, isA<BusinessDetailData>());
      expect(state!.business.id, 'b1');
      expect(state.media.length, 1);

      container.dispose();
    });

    test('build returns null when business not found', () async {
      when(() => mockBusinessesRepo.getBusinessById('999'))
          .thenAnswer((_) async => null);
      when(() => mockMediasRepo.getEntityMedia(
        entityType: any(named: 'entityType'),
        entityId: any(named: 'entityId'),
      )).thenAnswer((_) async => []);

      final container = createContainer();
      final state =
          await container.read(businessDetailProvider('999').future);

      expect(state, isNull);

      container.dispose();
    });

    test('build handles empty media', () async {
      when(() => mockBusinessesRepo.getBusinessById('b1'))
          .thenAnswer((_) async => testBusiness);
      when(() => mockMediasRepo.getEntityMedia(
        entityType: any(named: 'entityType'),
        entityId: any(named: 'entityId'),
      )).thenAnswer((_) async => []);

      final container = createContainer();
      final state =
          await container.read(businessDetailProvider('b1').future);

      expect(state, isA<BusinessDetailData>());
      expect(state!.media, isEmpty);

      container.dispose();
    });
  });
}
