import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ibiapabaapp/features/businesses/data/repositories/businesses_repository_impl.dart';
import 'package:ibiapabaapp/shared/models/business.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks/mocks.dart';

void main() {
  late MockDio mockDio;
  late MockCacheDatabaseService mockCacheService;
  late MockLogger mockLogger;
  late BusinessesRepositoryImpl sut;

  setUpAll(() {
    registerFallbackValue(Business(
      id: '0',
      name: '',
      slug: '',
      maxReachLevel: ReachLevel.local,
      categories: [],
      createdAt: DateTime(2025),
    ));
  });

  setUp(() {
    mockDio = MockDio();
    mockCacheService = MockCacheDatabaseService();
    mockLogger = MockLogger();
    sut = BusinessesRepositoryImpl(
      dio: mockDio,
      cacheService: mockCacheService,
      logger: mockLogger,
    );
  });

  Response<T> makeResponse<T>(T data, {int statusCode = 200}) {
    final response = MockResponse<T>();
    when(() => response.data).thenReturn(data);
    when(() => response.statusCode).thenReturn(statusCode);
    return response;
  }

  final businessJson = {
    'id': '1',
    'name': 'Business 1',
    'slug': 'business-1',
    'max_reach_level': 'local',
    'categories': ['cat1'],
    'created_at': '2025-01-01T00:00:00.000Z',
  };

  group('getAllBusinesses', () {
    test('returns cached businesses when cache is not empty', () async {
      final cached = [
        Business(
          id: '1',
          name: 'Business 1',
          slug: 'business-1',
          maxReachLevel: ReachLevel.local,
          categories: ['cat1'],
          createdAt: DateTime(2025),
        ),
      ];
      when(() => mockCacheService.getList<Business>(
        storeName: any(named: 'storeName'),
        key: any(named: 'key'),
        fromJson: any(named: 'fromJson'),
        maxAge: any(named: 'maxAge'),
      )).thenAnswer((_) async => cached);

      final result = await sut.getAllBusinesses();

      expect(result, equals(cached));
      verifyNever(() => mockDio.get(any()));
    });

    test('fetches from remote when cache is empty', () async {
      when(() => mockCacheService.getList<Business>(
        storeName: any(named: 'storeName'),
        key: any(named: 'key'),
        fromJson: any(named: 'fromJson'),
        maxAge: any(named: 'maxAge'),
      )).thenAnswer((_) async => []);

      when(() => mockDio.get('/businesses'))
          .thenAnswer((_) async => makeResponse([businessJson]));
      when(() => mockCacheService.saveList<Business>(
        storeName: any(named: 'storeName'),
        key: any(named: 'key'),
        items: any(named: 'items'),
        toMap: any(named: 'toMap'),
      )).thenAnswer((_) async {});

      final result = await sut.getAllBusinesses();

      expect(result.length, 1);
      expect(result.first.name, 'Business 1');
      verify(() => mockDio.get('/businesses')).called(1);
    });

    test('throws raw DioException on failure', () async {
      when(() => mockCacheService.getList<Business>(
        storeName: any(named: 'storeName'),
        key: any(named: 'key'),
        fromJson: any(named: 'fromJson'),
        maxAge: any(named: 'maxAge'),
      )).thenAnswer((_) async => []);

      when(() => mockDio.get('/businesses')).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/businesses'),
          response: Response(
            requestOptions: RequestOptions(path: '/businesses'),
            statusCode: 500,
            data: {'message': 'Server error'},
          ),
        ),
      );

      expect(() => sut.getAllBusinesses(), throwsA(isA<DioException>()));
    });
  });

  group('getBusinessById', () {
    test('returns business from individual cache', () async {
      final cached = Business(
        id: '1',
        name: 'Business 1',
        slug: 'business-1',
        maxReachLevel: ReachLevel.local,
        categories: ['cat1'],
        createdAt: DateTime(2025),
      );
      when(() => mockCacheService.getObject<Business>(
        storeName: any(named: 'storeName'),
        key: any(named: 'key'),
        fromJson: any(named: 'fromJson'),
        maxAge: any(named: 'maxAge'),
      )).thenAnswer((_) async => cached);

      final result = await sut.getBusinessById('1');

      expect(result, isNotNull);
      expect(result!.id, '1');
    });

    test('returns business from list cache when individual cache empty', () async {
      when(() => mockCacheService.getObject<Business>(
        storeName: any(named: 'storeName'),
        key: any(named: 'key'),
        fromJson: any(named: 'fromJson'),
        maxAge: any(named: 'maxAge'),
      )).thenAnswer((_) async => null);

      final cached = [
        Business(
          id: '1',
          name: 'Business 1',
          slug: 'business-1',
          maxReachLevel: ReachLevel.local,
          categories: ['cat1'],
          createdAt: DateTime(2025),
        ),
      ];
      when(() => mockCacheService.getList<Business>(
        storeName: any(named: 'storeName'),
        key: any(named: 'key'),
        fromJson: any(named: 'fromJson'),
        maxAge: any(named: 'maxAge'),
      )).thenAnswer((_) async => cached);

      final result = await sut.getBusinessById('1');

      expect(result, isNotNull);
      expect(result!.id, '1');
    });

    test('fetches from remote when not in cache', () async {
      when(() => mockCacheService.getObject<Business>(
        storeName: any(named: 'storeName'),
        key: any(named: 'key'),
        fromJson: any(named: 'fromJson'),
        maxAge: any(named: 'maxAge'),
      )).thenAnswer((_) async => null);

      when(() => mockCacheService.getList<Business>(
        storeName: any(named: 'storeName'),
        key: any(named: 'key'),
        fromJson: any(named: 'fromJson'),
        maxAge: any(named: 'maxAge'),
      )).thenAnswer((_) async => []);

      when(() => mockDio.get('/businesses/1'))
          .thenAnswer((_) async => makeResponse(businessJson));
      when(() => mockCacheService.saveObject<Business>(
        storeName: any(named: 'storeName'),
        key: any(named: 'key'),
        item: any(named: 'item'),
        toMap: any(named: 'toMap'),
      )).thenAnswer((_) async {});

      final result = await sut.getBusinessById('1');

      expect(result, isNotNull);
      expect(result!.name, 'Business 1');
      verify(() => mockDio.get('/businesses/1')).called(1);
    });

    test('throws raw DioException when business not found', () async {
      when(() => mockCacheService.getObject<Business>(
        storeName: any(named: 'storeName'),
        key: any(named: 'key'),
        fromJson: any(named: 'fromJson'),
        maxAge: any(named: 'maxAge'),
      )).thenAnswer((_) async => null);

      when(() => mockCacheService.getList<Business>(
        storeName: any(named: 'storeName'),
        key: any(named: 'key'),
        fromJson: any(named: 'fromJson'),
        maxAge: any(named: 'maxAge'),
      )).thenAnswer((_) async => []);

      when(() => mockDio.get('/businesses/999')).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/businesses/999'),
          response: Response(
            requestOptions: RequestOptions(path: '/businesses/999'),
            statusCode: 404,
            data: {'message': 'Not found'},
          ),
        ),
      );

      expect(
        () => sut.getBusinessById('999'),
        throwsA(isA<DioException>()),
      );
    });
  });
}
