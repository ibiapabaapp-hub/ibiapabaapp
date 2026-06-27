import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ibivibe/features/events/data/repositories/events_repository_impl.dart';
import 'package:ibivibe/shared/models/business.dart';
import 'package:ibivibe/shared/models/event.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks/mocks.dart';

void main() {
  late MockDio mockDio;
  late MockLogger mockLogger;
  late EventsRepositoryImpl sut;

  setUp(() {
    mockDio = MockDio();
    mockLogger = MockLogger();
    sut = EventsRepositoryImpl(dio: mockDio, logger: mockLogger);
  });

  Response<T> makeResponse<T>(T data, {int statusCode = 200}) {
    final response = MockResponse<T>();
    when(() => response.data).thenReturn(data);
    when(() => response.statusCode).thenReturn(statusCode);
    return response;
  }

  final eventJson = {
    'id': '1',
    'slug': 'event-1',
    'name': 'Event 1',
    'owner_account_id': 'acc1',
    'type': 'simple',
    'reach_level': 'local',
    'categories': ['cat1'],
    'start_date': '2025-06-01T00:00:00.000Z',
    'end_date': '2025-06-02T00:00:00.000Z',
    'created_at': '2025-01-01T00:00:00.000Z',
    'updated_at': '2025-01-01T00:00:00.000Z',
  };

  group('getAllEvents', () {
    test('returns list of events on success', () async {
      when(() => mockDio.get('/events'))
          .thenAnswer((_) async => makeResponse([eventJson]));

      final result = await sut.getAllEvents();

      expect(result.length, 1);
      expect(result.first.name, 'Event 1');
      expect(result.first.type, EventType.simple);
      expect(result.first.reachLevel, ReachLevel.local);
      verify(() => mockDio.get('/events')).called(1);
    });

    test('returns empty list when response is empty', () async {
      when(() => mockDio.get('/events'))
          .thenAnswer((_) async => makeResponse([]));

      final result = await sut.getAllEvents();

      expect(result, isEmpty);
    });

    test('throws raw DioException on failure', () async {
      when(() => mockDio.get('/events')).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/events'),
          response: Response(
            requestOptions: RequestOptions(path: '/events'),
            statusCode: 500,
            data: {'message': 'Server error'},
          ),
        ),
      );

      expect(() => sut.getAllEvents(), throwsA(isA<DioException>()));
    });
  });

  group('getEventById', () {
    test('returns event on success', () async {
      when(() => mockDio.get('/events/1'))
          .thenAnswer((_) async => makeResponse(eventJson));

      final result = await sut.getEventById('1');

      expect(result, isNotNull);
      expect(result!.id, '1');
      expect(result.name, 'Event 1');
    });

    test('throws raw DioException when event not found', () async {
      when(() => mockDio.get('/events/999')).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/events/999'),
          response: Response(
            requestOptions: RequestOptions(path: '/events/999'),
            statusCode: 404,
            data: {'message': 'Not found'},
          ),
        ),
      );

      expect(() => sut.getEventById('999'), throwsA(isA<DioException>()));
    });

    test('throws raw DioException on connection error', () async {
      when(() => mockDio.get('/events/1')).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/events/1'),
          type: DioExceptionType.connectionTimeout,
        ),
      );

      expect(() => sut.getEventById('1'), throwsA(isA<DioException>()));
    });
  });
}
