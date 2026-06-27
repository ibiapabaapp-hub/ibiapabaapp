import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ibiapabaapp/core/entities/entity_type.dart';
import 'package:ibiapabaapp/core/logger/logger.dart';
import 'package:ibiapabaapp/features/cities/domain/entities/city_detail_data.dart';
import 'package:ibiapabaapp/features/cities/presentation/controllers/city_detail_controller.dart';
import 'package:ibiapabaapp/features/cities/presentation/providers/cities_providers.dart';
import 'package:ibiapabaapp/features/medias/domain/repositories/medias_repository.dart';
import 'package:ibiapabaapp/features/medias/presentation/providers/medias_providers.dart';
import 'package:ibiapabaapp/shared/models/account.dart';
import 'package:ibiapabaapp/shared/models/account_type.dart';
import 'package:ibiapabaapp/shared/models/city.dart';
import 'package:ibiapabaapp/shared/models/media.dart';
import 'package:ibiapabaapp/shared/providers/accounts_state_provider.dart';
import 'package:logger/logger.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks/mocks.dart';

void main() {
  late MockCitiesRepository mockCitiesRepo;
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

  final testCity = City(
    id: 'c1',
    name: 'City 1',
    slug: 'city-1',
    categories: ['cat1'],
  );

  final testMedia = Media(
    id: 'm1',
    entityType: EntityType.city,
    entityId: 'c1',
    mediaType: MediaType.image,
    url: 'https://example.com/image.jpg',
    isCover: true,
    position: 0,
  );

  setUp(() {
    mockCitiesRepo = MockCitiesRepository();
    mockMediasRepo = MockMediasRepository();
    mockLogger = MockLogger();
  });

  setUpAll(() {
    registerFallbackValue(EntityType.city);
  });

  ProviderContainer createContainer() {
    return ProviderContainer(
      overrides: [
        accountsStateProvider.overrideWithValue(
          AccountsData(activeAccount: testAccount),
        ),
        citiesRepositoryProvider.overrideWithValue(mockCitiesRepo),
        mediasRepositoryProvider.overrideWithValue(mockMediasRepo),
        loggerProvider.overrideWithValue(mockLogger),
      ],
    );
  }

  group('city detail controller', () {
    test('build returns null when no active account', () async {
      final container = ProviderContainer(
        overrides: [
          accountsStateProvider.overrideWithValue(const AccountsData()),
          citiesRepositoryProvider.overrideWithValue(mockCitiesRepo),
          mediasRepositoryProvider.overrideWithValue(mockMediasRepo),
          loggerProvider.overrideWithValue(mockLogger),
        ],
      );

      final state = await container.read(cityDetailProvider('c1').future);
      expect(state, isNull);

      container.dispose();
    });

    test('build returns CityDetailData when city exists', () async {
      when(() => mockCitiesRepo.getCityById('c1'))
          .thenAnswer((_) async => testCity);
      when(() => mockMediasRepo.getEntityMedia(
        entityType: any(named: 'entityType'),
        entityId: any(named: 'entityId'),
      )).thenAnswer((_) async => [testMedia]);

      final container = createContainer();
      final state = await container.read(cityDetailProvider('c1').future);

      expect(state, isA<CityDetailData>());
      expect(state!.city.id, 'c1');
      expect(state.media.length, 1);

      container.dispose();
    });

    test('build returns null when city not found', () async {
      when(() => mockCitiesRepo.getCityById('999'))
          .thenAnswer((_) async => null);
      when(() => mockMediasRepo.getEntityMedia(
        entityType: any(named: 'entityType'),
        entityId: any(named: 'entityId'),
      )).thenAnswer((_) async => []);

      final container = createContainer();
      final state = await container.read(cityDetailProvider('999').future);

      expect(state, isNull);

      container.dispose();
    });

    test('build handles empty media', () async {
      when(() => mockCitiesRepo.getCityById('c1'))
          .thenAnswer((_) async => testCity);
      when(() => mockMediasRepo.getEntityMedia(
        entityType: any(named: 'entityType'),
        entityId: any(named: 'entityId'),
      )).thenAnswer((_) async => []);

      final container = createContainer();
      final state = await container.read(cityDetailProvider('c1').future);

      expect(state, isA<CityDetailData>());
      expect(state!.media, isEmpty);

      container.dispose();
    });
  });
}
