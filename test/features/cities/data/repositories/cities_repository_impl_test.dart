import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ibivibe/features/cities/cities_repository_impl.dart';
import 'package:ibivibe/shared/models/city.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks/mocks.dart';

void main() {
  late MockDio mockDio;
  late MockCacheDatabaseService mockCacheService;
  late MockLogger mockLogger;
  late CitiesRepositoryImpl sut;

  setUp(() {
    mockDio = MockDio();
    mockCacheService = MockCacheDatabaseService();
    mockLogger = MockLogger();
    sut = CitiesRepositoryImpl(
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

  group('getAllCities', () {
    test('returns cached cities when cache is not empty', () async {
      final cached = [
        City(id: '1', name: 'City 1', slug: 'city-1', categories: []),
      ];
      when(() => mockCacheService.getList<City>(
        storeName: any(named: 'storeName'),
        fromJson: any(named: 'fromJson'),
        maxAge: any(named: 'maxAge'),
      )).thenAnswer((_) async => cached);

      final result = await sut.getAllCities();

      expect(result, equals(cached));
      verifyNever(() => mockDio.get(any()));
    });

    test('fetches from remote when cache is empty', () async {
      when(() => mockCacheService.getList<City>(
        storeName: any(named: 'storeName'),
        fromJson: any(named: 'fromJson'),
        maxAge: any(named: 'maxAge'),
      )).thenAnswer((_) async => []);

      final citiesJson = [
        {
          'id': '1',
          'name': 'City 1',
          'slug': 'city-1',
          'categories': [],
        },
      ];
      when(() => mockDio.get('/cities'))
          .thenAnswer((_) async => makeResponse(citiesJson));
      when(() => mockCacheService.clear(storeName: any(named: 'storeName')))
          .thenAnswer((_) async {});
      when(() => mockCacheService.saveList<City>(
        storeName: any(named: 'storeName'),
        items: any(named: 'items'),
        toMap: any(named: 'toMap'),
      )).thenAnswer((_) async {});

      final result = await sut.getAllCities();

      expect(result.length, 1);
      expect(result.first.name, 'City 1');
      verify(() => mockDio.get('/cities')).called(1);
    });

    test('forces refresh when forceRefresh is true', () async {
      when(() => mockDio.get('/cities')).thenAnswer(
        (_) async => makeResponse([
          {'id': '1', 'name': 'City 1', 'slug': 'city-1', 'categories': []},
        ]),
      );
      when(() => mockCacheService.clear(storeName: any(named: 'storeName')))
          .thenAnswer((_) async {});
      when(() => mockCacheService.saveList<City>(
        storeName: any(named: 'storeName'),
        items: any(named: 'items'),
        toMap: any(named: 'toMap'),
      )).thenAnswer((_) async {});

      final result = await sut.getAllCities(forceRefresh: true);

      expect(result.length, 1);
      verify(() => mockDio.get('/cities')).called(1);
    });

    test('throws raw DioException on failure', () async {
      when(() => mockCacheService.getList<City>(
        storeName: any(named: 'storeName'),
        fromJson: any(named: 'fromJson'),
        maxAge: any(named: 'maxAge'),
      )).thenAnswer((_) async => []);

      when(() => mockDio.get('/cities')).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/cities'),
          response: Response(
            requestOptions: RequestOptions(path: '/cities'),
            statusCode: 500,
            data: {'message': 'Server error'},
          ),
        ),
      );

      expect(() => sut.getAllCities(), throwsA(isA<DioException>()));
    });
  });

  group('getCityById', () {
    test('returns city from cache', () async {
      final cached = [
        City(id: '1', name: 'City 1', slug: 'city-1', categories: []),
      ];
      when(() => mockCacheService.getList<City>(
        storeName: any(named: 'storeName'),
        fromJson: any(named: 'fromJson'),
        maxAge: any(named: 'maxAge'),
      )).thenAnswer((_) async => cached);

      final result = await sut.getCityById('1');

      expect(result, isNotNull);
      expect(result!.id, '1');
    });

    test('returns null when city not found in cache', () async {
      when(() => mockCacheService.getList<City>(
        storeName: any(named: 'storeName'),
        fromJson: any(named: 'fromJson'),
        maxAge: any(named: 'maxAge'),
      )).thenAnswer((_) async => []);

      final result = await sut.getCityById('999');

      expect(result, isNull);
    });
  });
}
