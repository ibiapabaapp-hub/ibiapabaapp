import 'package:flutter_test/flutter_test.dart';
import 'package:ibivibe/features/favorites/favorites_repository_impl.dart';
import 'package:ibivibe/features/favorites/models/favorite.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/mocks.dart';

void main() {
  late MockFavoritesRemoteDatasource mockRemote;
  late MockFavoritesLocalStorage mockLocalStorage;
  late MockLogger mockLogger;
  late FavoritesRepositoryImpl sut;

  setUpAll(() {
    registerFallbackValue(
      Favorite(id: '0', accountId: '', cityId: null, eventId: null, businessId: null),
    );
  });

  setUp(() {
    mockRemote = MockFavoritesRemoteDatasource();
    mockLocalStorage = MockFavoritesLocalStorage();
    mockLogger = MockLogger();
    sut = FavoritesRepositoryImpl(
      remoteDatasource: mockRemote,
      localStorage: mockLocalStorage,
      logger: mockLogger,
    );
  });

  final testFavorite = Favorite(
    id: '1',
    accountId: 'acc1',
    cityId: 'city1',
    eventId: null,
    businessId: null,
  );

  group('getAllFavoritesByAccount', () {
    test('returns cached favorites when available', () async {
      when(() => mockLocalStorage.loadFavoritesByAccount(accountId: 'acc1'))
          .thenAnswer((_) async => [testFavorite]);

      final result = await sut.getAllFavoritesByAccount(accountId: 'acc1');

      expect(result.length, 1);
      expect(result.first.id, '1');
      verifyNever(() => mockRemote.getAllFavoritesByAccount(accountId: any(named: 'accountId')));
    });

    test('fetches from remote when cache is empty', () async {
      when(() => mockLocalStorage.loadFavoritesByAccount(accountId: 'acc1'))
          .thenAnswer((_) async => []);
      when(() => mockRemote.getAllFavoritesByAccount(accountId: 'acc1'))
          .thenAnswer((_) async => [testFavorite]);
      when(() => mockLocalStorage.saveFavoritesByAccount(
        accountId: any(named: 'accountId'),
        favorites: any(named: 'favorites'),
      )).thenAnswer((_) async {});

      final result = await sut.getAllFavoritesByAccount(accountId: 'acc1');

      expect(result.length, 1);
      verify(() => mockRemote.getAllFavoritesByAccount(accountId: 'acc1')).called(1);
      verify(() => mockLocalStorage.saveFavoritesByAccount(
        accountId: 'acc1',
        favorites: [testFavorite],
      )).called(1);
    });

    test('rethrows exceptions', () async {
      when(() => mockLocalStorage.loadFavoritesByAccount(accountId: 'acc1'))
          .thenAnswer((_) async => []);
      when(() => mockRemote.getAllFavoritesByAccount(accountId: 'acc1'))
          .thenThrow(Exception('network error'));

      expect(
        () => sut.getAllFavoritesByAccount(accountId: 'acc1'),
        throwsA(isA<Exception>()),
      );
    });
  });

  group('pushFavorite', () {
    test('pushes favorite and saves to local', () async {
      final pushedFavorite = Favorite(
        id: '2',
        accountId: 'acc1',
        cityId: 'city2',
        eventId: null,
        businessId: null,
      );
      when(() => mockRemote.pushFavorite(favorite: any(named: 'favorite')))
          .thenAnswer((_) async => pushedFavorite);
      when(() => mockLocalStorage.pushFavorite(favorite: any(named: 'favorite')))
          .thenAnswer((_) async {});

      final result = await sut.pushFavorite(favorite: testFavorite);

      expect(result.id, '2');
      verify(() => mockRemote.pushFavorite(favorite: testFavorite)).called(1);
      verify(() => mockLocalStorage.pushFavorite(favorite: pushedFavorite)).called(1);
    });

    test('rethrows exceptions', () async {
      when(() => mockRemote.pushFavorite(favorite: any(named: 'favorite')))
          .thenThrow(Exception('network error'));

      expect(
        () => sut.pushFavorite(favorite: testFavorite),
        throwsA(isA<Exception>()),
      );
    });
  });

  group('popFavorite', () {
    test('pops favorite and removes from local', () async {
      final poppedFavorite = Favorite(
        id: '1',
        accountId: 'acc1',
        cityId: null,
        eventId: null,
        businessId: null,
      );
      when(() => mockRemote.popFavorite(favorite: any(named: 'favorite')))
          .thenAnswer((_) async => poppedFavorite);
      when(() => mockLocalStorage.popFavorite(favorite: any(named: 'favorite')))
          .thenAnswer((_) async {});

      final result = await sut.popFavorite(favorite: testFavorite);

      expect(result.id, '1');
      verify(() => mockRemote.popFavorite(favorite: testFavorite)).called(1);
      verify(() => mockLocalStorage.popFavorite(favorite: testFavorite)).called(1);
    });

    test('rethrows exceptions', () async {
      when(() => mockRemote.popFavorite(favorite: any(named: 'favorite')))
          .thenThrow(Exception('network error'));

      expect(
        () => sut.popFavorite(favorite: testFavorite),
        throwsA(isA<Exception>()),
      );
    });
  });
}
