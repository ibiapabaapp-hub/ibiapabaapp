import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ibivibe/core/errors/exceptions/exceptions.dart';
import 'package:ibivibe/features/tags/tags_repository_impl.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/mocks.dart';

void main() {
  late MockDio mockDio;
  late MockLogger mockLogger;
  late TagsRepositoryImpl sut;

  setUp(() {
    mockDio = MockDio();
    mockLogger = MockLogger();
    sut = TagsRepositoryImpl(logger: mockLogger, dio: mockDio);
  });

  Response<T> makeResponse<T>(T data, {int statusCode = 200}) {
    final response = MockResponse<T>();
    when(() => response.data).thenReturn(data);
    when(() => response.statusCode).thenReturn(statusCode);
    return response;
  }

  final tagGroupJson = {
    'id': '1',
    'name': 'Gastronomia',
    'description': 'Restaurantes e comida',
    'tags': [
      {
        'id': 't1',
        'name': 'Restaurante',
        'slug': 'restaurante',
        'group_id': '1',
        'position': 0,
      },
    ],
  };

  group('getTagGroups', () {
    test('returns list of tag groups on success', () async {
      when(() => mockDio.get('/tags/groups'))
          .thenAnswer((_) async => makeResponse([tagGroupJson]));

      final result = await sut.getTagGroups();

      expect(result.length, 1);
      expect(result.first.id, '1');
      expect(result.first.name, 'Gastronomia');
      verify(() => mockDio.get('/tags/groups')).called(1);
    });

    test('returns empty list when response is empty', () async {
      when(() => mockDio.get('/tags/groups'))
          .thenAnswer((_) async => makeResponse([]));

      final result = await sut.getTagGroups();

      expect(result, isEmpty);
    });

    test('returns empty list when data is not a list', () async {
      when(() => mockDio.get('/tags/groups'))
          .thenAnswer((_) async => makeResponse('invalid'));

      final result = await sut.getTagGroups();

      expect(result, isEmpty);
    });

    test('throws AppException on DioException with response', () async {
      when(() => mockDio.get('/tags/groups')).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/tags/groups'),
          response: Response(
            requestOptions: RequestOptions(path: '/tags/groups'),
            statusCode: 500,
            data: {'message': 'Server error'},
          ),
        ),
      );

      expect(() => sut.getTagGroups(), throwsA(isA<ServerException>()));
    });

    test('throws NetworkException on DioException without response', () async {
      when(() => mockDio.get('/tags/groups')).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/tags/groups'),
        ),
      );

      expect(() => sut.getTagGroups(), throwsA(isA<NetworkException>()));
    });

    test('throws BadRequestException on 400', () async {
      when(() => mockDio.get('/tags/groups')).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/tags/groups'),
          response: Response(
            requestOptions: RequestOptions(path: '/tags/groups'),
            statusCode: 400,
            data: {'message': 'Bad request'},
          ),
        ),
      );

      expect(() => sut.getTagGroups(), throwsA(isA<BadRequestException>()));
    });

    test('throws NotFoundException on 404', () async {
      when(() => mockDio.get('/tags/groups')).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/tags/groups'),
          response: Response(
            requestOptions: RequestOptions(path: '/tags/groups'),
            statusCode: 404,
            data: {'message': 'Not found'},
          ),
        ),
      );

      expect(() => sut.getTagGroups(), throwsA(isA<NotFoundException>()));
    });
  });
}
