import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ibivibe/core/entities/entity_type.dart';
import 'package:ibivibe/core/errors/exceptions/exceptions.dart';
import 'package:ibivibe/features/medias/medias_repository_impl.dart';
import 'package:ibivibe/shared/models/media.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks/mocks.dart';

void main() {
  late MockMediasRemoteDatasource mockRemoteDatasource;
  late MediasRepositoryImpl sut;

  setUpAll(() {
    registerFallbackValue(EntityType.city);
    registerFallbackValue('');
  });

  setUp(() {
    mockRemoteDatasource = MockMediasRemoteDatasource();
    sut = MediasRepositoryImpl(remoteDatasource: mockRemoteDatasource);
  });

  final testMedia = const Media(
    id: '1',
    entityType: EntityType.city,
    entityId: 'city1',
    mediaType: MediaType.image,
    url: 'https://example.com/image.jpg',
    isCover: true,
    position: 0,
  );

  group('getEntityMedia', () {
    test('returns list of media on success', () async {
      when(() => mockRemoteDatasource.getEntityMedia(
        entityType: any(named: 'entityType'),
        entityId: any(named: 'entityId'),
      )).thenAnswer((_) async => [testMedia]);

      final result = await sut.getEntityMedia(
        entityType: EntityType.city,
        entityId: 'city1',
      );

      expect(result.length, 1);
      expect(result.first.id, '1');
      expect(result.first.url, 'https://example.com/image.jpg');
      verify(() => mockRemoteDatasource.getEntityMedia(
        entityType: EntityType.city,
        entityId: 'city1',
      )).called(1);
    });

    test('returns empty list when no media', () async {
      when(() => mockRemoteDatasource.getEntityMedia(
        entityType: any(named: 'entityType'),
        entityId: any(named: 'entityId'),
      )).thenAnswer((_) async => []);

      final result = await sut.getEntityMedia(
        entityType: EntityType.city,
        entityId: 'city1',
      );

      expect(result, isEmpty);
    });

    test('throws mapped exception on DioException', () async {
      when(() => mockRemoteDatasource.getEntityMedia(
        entityType: any(named: 'entityType'),
        entityId: any(named: 'entityId'),
      )).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/cities/city1/media'),
          response: Response(
            requestOptions: RequestOptions(path: '/cities/city1/media'),
            statusCode: 500,
            data: {'message': 'Server error'},
          ),
        ),
      );

      expect(
        () => sut.getEntityMedia(
          entityType: EntityType.city,
          entityId: 'city1',
        ),
        throwsA(isA<ServerException>()),
      );
    });

    test('handles business entity type', () async {
      when(() => mockRemoteDatasource.getEntityMedia(
        entityType: any(named: 'entityType'),
        entityId: any(named: 'entityId'),
      )).thenAnswer((_) async => [testMedia]);

      final result = await sut.getEntityMedia(
        entityType: EntityType.business,
        entityId: 'biz1',
      );

      expect(result.length, 1);
      verify(() => mockRemoteDatasource.getEntityMedia(
        entityType: EntityType.business,
        entityId: 'biz1',
      )).called(1);
    });

    test('handles event entity type', () async {
      when(() => mockRemoteDatasource.getEntityMedia(
        entityType: any(named: 'entityType'),
        entityId: any(named: 'entityId'),
      )).thenAnswer((_) async => [testMedia]);

      final result = await sut.getEntityMedia(
        entityType: EntityType.event,
        entityId: 'evt1',
      );

      expect(result.length, 1);
      verify(() => mockRemoteDatasource.getEntityMedia(
        entityType: EntityType.event,
        entityId: 'evt1',
      )).called(1);
    });
  });
}
