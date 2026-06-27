import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ibiapabaapp/core/errors/exceptions/exceptions.dart';
import 'package:ibiapabaapp/features/accounts/data/repositories/accounts_repository_impl.dart';
import 'package:ibiapabaapp/features/accounts/domain/entities/account_interests.dart';
import 'package:ibiapabaapp/features/accounts/domain/entities/account_interests_response.dart';
import 'package:ibiapabaapp/shared/models/account.dart';
import 'package:ibiapabaapp/shared/models/account_type.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks/mocks.dart';

void main() {
  late MockDio mockDio;
  late MockAccountsLocalStorage mockLocalStorage;
  late MockLogger mockLogger;
  late AccountsRepositoryImpl sut;

  setUpAll(() {
    registerFallbackValue(
      Account(
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
      ),
    );
  });

  setUp(() {
    mockDio = MockDio();
    mockLocalStorage = MockAccountsLocalStorage();
    mockLogger = MockLogger();
    sut = AccountsRepositoryImpl(
      dio: mockDio,
      localStorage: mockLocalStorage,
      logger: mockLogger,
    );
  });

  final accountJson = {
    'id': '1',
    'email': 'test@test.com',
    'name': 'Test User',
    'active': true,
    'is_verified': true,
    'created_at': '2025-01-01T00:00:00.000Z',
    'updated_at': '2025-01-01T00:00:00.000Z',
    'slug': 'test-user',
    'display_name': 'Test User',
    'type': 'personal',
  };

  Response<T> makeResponse<T>(T data, {int statusCode = 200}) {
    final response = MockResponse<T>();
    when(() => response.data).thenReturn(data);
    when(() => response.statusCode).thenReturn(statusCode);
    return response;
  }

  group('getCachedAccounts', () {
    test('returns cached accounts from local storage', () async {
      final accounts = [
        Account(
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
        ),
      ];
      when(() => mockLocalStorage.getCachedAccounts())
          .thenAnswer((_) async => accounts);

      final result = await sut.getCachedAccounts();

      expect(result, equals(accounts));
      verify(() => mockLocalStorage.getCachedAccounts()).called(1);
    });
  });

  group('addCachedAccount', () {
    test('delegates to local storage', () async {
      final account = Account(
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
      when(() => mockLocalStorage.addCachedAccount(any()))
          .thenAnswer((_) async {});

      await sut.addCachedAccount(account);

      verify(() => mockLocalStorage.addCachedAccount(account)).called(1);
    });
  });

  group('removeCachedAccount', () {
    test('delegates to local storage', () async {
      when(() => mockLocalStorage.removeCachedAccount('1'))
          .thenAnswer((_) async {});

      await sut.removeCachedAccount('1');

      verify(() => mockLocalStorage.removeCachedAccount('1')).called(1);
    });
  });

  group('removeAccount', () {
    test('calls delete endpoint and removes from cache', () async {
      when(() => mockDio.delete('/accounts/1'))
          .thenAnswer((_) async => makeResponse(null));
      when(() => mockLocalStorage.removeCachedAccount('1'))
          .thenAnswer((_) async {});

      await sut.removeAccount('1');

      verify(() => mockDio.delete('/accounts/1')).called(1);
      verify(() => mockLocalStorage.removeCachedAccount('1')).called(1);
    });

    test('throws mapped exception on DioException', () async {
      when(() => mockDio.delete('/accounts/1')).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/accounts/1'),
          response: Response(
            requestOptions: RequestOptions(path: '/accounts/1'),
            statusCode: 500,
            data: {'message': 'Server error'},
          ),
        ),
      );

      expect(() => sut.removeAccount('1'), throwsA(isA<ServerException>()));
    });
  });

  group('updateAccount', () {
    test('returns updated account on success', () async {
      when(() => mockDio.patch('/accounts/1', data: {'name': 'New Name'}))
          .thenAnswer((_) async => makeResponse({...accountJson, 'name': 'New Name'}));
      when(() => mockLocalStorage.addCachedAccount(any()))
          .thenAnswer((_) async {});

      final result = await sut.updateAccount(
        accountId: '1',
        updates: {'name': 'New Name'},
      );

      expect(result.name, 'New Name');
      verify(() => mockLocalStorage.addCachedAccount(any())).called(1);
    });

    test('throws mapped exception on DioException', () async {
      when(() => mockDio.patch('/accounts/1', data: any(named: 'data')))
          .thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/accounts/1'),
          response: Response(
            requestOptions: RequestOptions(path: '/accounts/1'),
            statusCode: 400,
            data: {'message': 'Bad request'},
          ),
        ),
      );

      expect(
        () => sut.updateAccount(accountId: '1', updates: {}),
        throwsA(isA<BadRequestException>()),
      );
    });
  });

  group('getAccountInterests', () {
    test('returns interests on success', () async {
      final interestsJson = {
        'businesses': [
          {'id': 'b1', 'name': 'Business 1'},
        ],
        'events': [
          {'id': 'e1', 'name': 'Event 1'},
        ],
      };
      when(() => mockDio.get('/accounts/1/interests'))
          .thenAnswer((_) async => makeResponse(interestsJson));

      final result = await sut.getAccountInterests('1');

      expect(result, isA<AccountInterests>());
      expect(result.businesses.length, 1);
      expect(result.events.length, 1);
    });

    test('throws mapped exception on DioException', () async {
      when(() => mockDio.get('/accounts/1/interests')).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/accounts/1/interests'),
          response: Response(
            requestOptions: RequestOptions(path: '/accounts/1/interests'),
            statusCode: 404,
            data: {'message': 'Not found'},
          ),
        ),
      );

      expect(
        () => sut.getAccountInterests('1'),
        throwsA(isA<NotFoundException>()),
      );
    });
  });

  group('updateAccountInterests', () {
    test('returns response on success', () async {
      final interests = AccountInterests(
        businesses: [Interest(id: 'b1', name: 'Business 1')],
        events: [Interest(id: 'e1', name: 'Event 1')],
      );
      when(() => mockDio.post('/accounts/1/interests', data: any(named: 'data')))
          .thenAnswer((_) async => makeResponse({'count': 2}));

      final result = await sut.updateAccountInterests(
        accountId: '1',
        interests: interests,
      );

      expect(result, isA<AccountInterestsResponse>());
      expect(result.count, 2);
    });

    test('throws mapped exception on DioException', () async {
      final interests = AccountInterests(businesses: [], events: []);
      when(() => mockDio.post('/accounts/1/interests', data: any(named: 'data')))
          .thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/accounts/1/interests'),
          response: Response(
            requestOptions: RequestOptions(path: '/accounts/1/interests'),
            statusCode: 500,
            data: {'message': 'Server error'},
          ),
        ),
      );

      expect(
        () => sut.updateAccountInterests(accountId: '1', interests: interests),
        throwsA(isA<ServerException>()),
      );
    });
  });

  group('saveActiveAccountId', () {
    test('delegates to local storage', () async {
      when(() => mockLocalStorage.saveActiveAccountId('1'))
          .thenAnswer((_) async {});

      await sut.saveActiveAccountId('1');

      verify(() => mockLocalStorage.saveActiveAccountId('1')).called(1);
    });
  });

  group('getActiveAccountId', () {
    test('returns active account id from local storage', () async {
      when(() => mockLocalStorage.getActiveAccountId())
          .thenAnswer((_) async => '1');

      final result = await sut.getActiveAccountId();

      expect(result, '1');
    });
  });

  group('clearActiveAccountId', () {
    test('delegates to local storage', () async {
      when(() => mockLocalStorage.clearActiveAccountId())
          .thenAnswer((_) async {});

      await sut.clearActiveAccountId();

      verify(() => mockLocalStorage.clearActiveAccountId()).called(1);
    });
  });
}
