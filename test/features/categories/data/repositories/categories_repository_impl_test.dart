import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ibivibe/core/entities/entity_type.dart';
import 'package:ibivibe/core/errors/exceptions/exceptions.dart';
import 'package:ibivibe/features/categories/data/repositories/categories_repository_impl.dart';
import 'package:ibivibe/shared/models/child_category.dart';
import 'package:ibivibe/shared/models/category_entity.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks/mocks.dart';

void main() {
  late MockDio mockDio;
  late MockCacheDatabaseService mockCacheService;
  late MockLogger mockLogger;
  late CategoriesRepositoryImpl sut;

  setUp(() {
    mockDio = MockDio();
    mockCacheService = MockCacheDatabaseService();
    mockLogger = MockLogger();
    sut = CategoriesRepositoryImpl(
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

  group('getParentCategories', () {
    test('returns parent categories on success', () async {
      final categoriesJson = [
        {
          'id': 'p1',
          'name': 'Parent 1',
          'entities': ['city', 'business'],
          'children': [
            {
              'id': 'c1',
              'name': 'Child 1',
              'entities': ['city'],
            },
          ],
        },
      ];
      when(() => mockDio.get('/categories/parents'))
          .thenAnswer((_) async => makeResponse(categoriesJson));

      final result = await sut.getParentCategories();

      expect(result.length, 1);
      expect(result.first.name, 'Parent 1');
      expect(result.first.children?.length, 1);
    });

    test('includes entity query param when entity is provided', () async {
      when(() => mockDio.get('/categories/parents?entity=business'))
          .thenAnswer((_) async => makeResponse([]));

      final result = await sut.getParentCategories(
        entity: CategoryEntity.business,
      );

      expect(result, isEmpty);
      verify(() => mockDio.get('/categories/parents?entity=business')).called(1);
    });

    test('returns empty list when response is not a list', () async {
      when(() => mockDio.get('/categories/parents'))
          .thenAnswer((_) async => makeResponse({'error': 'bad'}));

      final result = await sut.getParentCategories();

      expect(result, isEmpty);
    });

    test('throws on DioException', () async {
      when(() => mockDio.get('/categories/parents')).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/categories/parents'),
          response: Response(
            requestOptions: RequestOptions(path: '/categories/parents'),
            statusCode: 500,
            data: {'message': 'Server error'},
          ),
        ),
      );

      expect(
        () => sut.getParentCategories(),
        throwsA(isA<ServerException>()),
      );
    });
  });

  group('getChildrenCategories', () {
    test('returns cached children when cache is not empty', () async {
      final cached = [
        const ChildCategory(id: 'c1', name: 'Child 1', entities: [EntityType.city]),
      ];
      when(() => mockCacheService.getList<ChildCategory>(
        storeName: any(named: 'storeName'),
        key: any(named: 'key'),
        fromJson: any(named: 'fromJson'),
        maxAge: any(named: 'maxAge'),
      )).thenAnswer((_) async => cached);

      final result = await sut.getChildrenCategories(parentId: 'p1');

      expect(result.length, 1);
      expect(result.first.id, 'c1');
      verifyNever(() => mockDio.get(any()));
    });

    test('fetches from remote when cache is empty', () async {
      when(() => mockCacheService.getList<ChildCategory>(
        storeName: any(named: 'storeName'),
        key: any(named: 'key'),
        fromJson: any(named: 'fromJson'),
        maxAge: any(named: 'maxAge'),
      )).thenAnswer((_) async => []);

      final childrenJson = [
        {
          'id': 'c1',
          'name': 'Child 1',
          'entities': ['city'],
        },
      ];
      when(() => mockDio.get('/categories/parents/p1/children'))
          .thenAnswer((_) async => makeResponse(childrenJson));
      when(() => mockCacheService.saveList<ChildCategory>(
        storeName: any(named: 'storeName'),
        key: any(named: 'key'),
        items: any(named: 'items'),
        toMap: any(named: 'toMap'),
      )).thenAnswer((_) async {});

      final result = await sut.getChildrenCategories(parentId: 'p1');

      expect(result.length, 1);
      expect(result.first.name, 'Child 1');
      verify(() => mockDio.get('/categories/parents/p1/children')).called(1);
    });

    test('forces refresh when forceRefresh is true', () async {
      final childrenJson = [
        {
          'id': 'c1',
          'name': 'Child 1',
          'entities': ['city'],
        },
      ];
      when(() => mockCacheService.getList<ChildCategory>(
        storeName: any(named: 'storeName'),
        key: any(named: 'key'),
        fromJson: any(named: 'fromJson'),
        maxAge: any(named: 'maxAge'),
      )).thenAnswer((_) async => []);

      when(() => mockDio.get('/categories/parents/p1/children'))
          .thenAnswer((_) async => makeResponse(childrenJson));
      when(() => mockCacheService.saveList<ChildCategory>(
        storeName: any(named: 'storeName'),
        key: any(named: 'key'),
        items: any(named: 'items'),
        toMap: any(named: 'toMap'),
      )).thenAnswer((_) async {});

      final result = await sut.getChildrenCategories(
        parentId: 'p1',
        forceRefresh: true,
      );

      expect(result.length, 1);
      verify(() => mockDio.get('/categories/parents/p1/children')).called(1);
    });

    test('throws on DioException', () async {
      when(() => mockCacheService.getList<ChildCategory>(
        storeName: any(named: 'storeName'),
        key: any(named: 'key'),
        fromJson: any(named: 'fromJson'),
        maxAge: any(named: 'maxAge'),
      )).thenAnswer((_) async => []);

      when(() => mockDio.get('/categories/parents/p1/children')).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/categories/parents/p1/children'),
          response: Response(
            requestOptions: RequestOptions(path: '/categories/parents/p1/children'),
            statusCode: 500,
            data: {'message': 'Server error'},
          ),
        ),
      );

      expect(
        () => sut.getChildrenCategories(parentId: 'p1'),
        throwsA(isA<ServerException>()),
      );
    });
  });
}
