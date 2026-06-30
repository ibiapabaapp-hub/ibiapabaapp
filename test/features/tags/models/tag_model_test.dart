import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:ibivibe/features/tags/models/tag_model.dart';
import '../../../fixtures/fixture_reader.dart';

void main() {
  final jsonString = fixture('tag.json');
  final jsonMap = json.decode(jsonString) as Map<String, dynamic>;

  group('TagModel', () {
    group('fromJson', () {
      test('should return a valid model from JSON', () {
        final result = TagModel.fromJson(jsonMap);
        expect(result, isA<TagModel>());
        expect(result.id, equals('test-tag-id'));
        expect(result.name, equals('Test Tag'));
        expect(result.slug, equals('test-tag'));
        expect(result.description, isNull);
        expect(result.color, isNull);
        expect(result.groupId, equals('test-tag-group-id'));
        expect(result.position, equals(0));
      });

      test('should handle null optional fields', () {
        final json = {...jsonMap}
          ..remove('description')
          ..remove('color');
        final result = TagModel.fromJson(json);
        expect(result.description, isNull);
        expect(result.color, isNull);
      });

      test('should handle missing fields with defaults', () {
        final json = <String, dynamic>{
          'group_id': 'g1',
        };
        final result = TagModel.fromJson(json);
        expect(result.id, equals(''));
        expect(result.name, equals(''));
        expect(result.slug, equals(''));
        expect(result.groupId, equals('g1'));
        expect(result.position, equals(0));
      });
    });

    group('toJson', () {
      test('should return a valid JSON map', () {
        final model = TagModel.fromJson(jsonMap);
        final result = model.toJson();
        expect(result['id'], equals('test-tag-id'));
        expect(result['name'], equals('Test Tag'));
        expect(result['slug'], equals('test-tag'));
        expect(result['group_id'], equals('test-tag-group-id'));
        expect(result['position'], equals(0));
      });
    });

    group('equality', () {
      test('should be equal when fields match', () {
        final a = TagModel.fromJson(jsonMap);
        final b = TagModel.fromJson(jsonMap);
        expect(a, equals(b));
      });

      test('should not be equal when id differs', () {
        final a = TagModel.fromJson(jsonMap);
        final b = TagModel(
          id: 'different-id',
          name: a.name,
          slug: a.slug,
          groupId: a.groupId,
        );
        expect(a, isNot(equals(b)));
      });
    });
  });

  group('fromJsonList', () {
    test('should return empty list for null input', () {
      expect(TagModel.fromJsonList(null), isEmpty);
    });

    test('should return empty list for empty input', () {
      expect(TagModel.fromJsonList([]), isEmpty);
    });

    test('should parse list of tags', () {
      final result = TagModel.fromJsonList([jsonMap]);
      expect(result.length, equals(1));
      expect(result.first.id, equals('test-tag-id'));
    });

    test('should skip invalid entries', () {
      final result = TagModel.fromJsonList([jsonMap, 'invalid', 123]);
      expect(result.length, equals(1));
    });
  });
}
