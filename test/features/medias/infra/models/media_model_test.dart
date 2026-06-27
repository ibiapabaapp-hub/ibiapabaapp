import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:ibiapabaapp/features/medias/infra/models/media_model.dart';
import '../../../../fixtures/fixture_reader.dart';

void main() {
  final jsonString = fixture('media.json');
  final jsonMap = json.decode(jsonString) as Map<String, dynamic>;

  group('MediaModel', () {
    group('fromJson', () {
      test('should return a valid model from JSON', () {
        final result = MediaModel.fromJson(jsonMap);
        expect(result, isA<MediaModel>());
        expect(result.id, equals('test-media-id'));
        expect(result.entityId, equals('test-city-id'));
        expect(result.url, equals('https://example.com/media.jpg'));
        expect(result.thumbnailUrl, equals('https://example.com/thumb.jpg'));
        expect(result.altText, equals('Test media'));
        expect(result.isCover, isTrue);
        expect(result.position, equals(0));
      });

      test('should handle null optional fields', () {
        final json = {...jsonMap}
          ..remove('thumbnail_url')
          ..remove('alt_text');
        final result = MediaModel.fromJson(json);
        expect(result.thumbnailUrl, isNull);
        expect(result.altText, isNull);
      });

      test('should default isCover to false when missing', () {
        final json = {...jsonMap}..remove('is_cover');
        final result = MediaModel.fromJson(json);
        expect(result.isCover, isFalse);
      });

      test('should default position to 0 when missing', () {
        final json = {...jsonMap}..remove('position');
        final result = MediaModel.fromJson(json);
        expect(result.position, equals(0));
      });

      test('should parse video media type', () {
        final json = {...jsonMap, 'media_type': 'video'};
        final result = MediaModel.fromJson(json);
        expect(result.mediaType.name, equals('video'));
      });

      test('should parse image media type', () {
        final json = {...jsonMap, 'media_type': 'image'};
        final result = MediaModel.fromJson(json);
        expect(result.mediaType.name, equals('image'));
      });
    });

    group('equality', () {
      test('should be equal when fields match', () {
        final a = MediaModel.fromJson(jsonMap);
        final b = MediaModel.fromJson(jsonMap);
        expect(a, equals(b));
      });

      test('should not be equal when id differs', () {
        final a = MediaModel.fromJson(jsonMap);
        final b = MediaModel(
          id: 'different-id',
          entityType: a.entityType,
          entityId: a.entityId,
          mediaType: a.mediaType,
          url: a.url,
          isCover: a.isCover,
          position: a.position,
        );
        expect(a, isNot(equals(b)));
      });
    });
  });
}
