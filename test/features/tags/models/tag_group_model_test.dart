import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:ibivibe/features/tags/models/tag_group_model.dart';
import '../../../fixtures/fixture_reader.dart';

void main() {
  final jsonString = fixture('tag_group.json');
  final jsonMap = json.decode(jsonString) as Map<String, dynamic>;

  group('TagGroupModel', () {
    group('fromJson', () {
      test('should return a valid model from JSON', () {
        final result = TagGroupModel.fromJson(jsonMap);
        expect(result, isA<TagGroupModel>());
        expect(result.id, equals('test-tag-group-id'));
        expect(result.name, equals('Test Tag Group'));
        expect(result.description, equals('A test tag group'));
        expect(result.tags, isNotEmpty);
        expect(result.tags.length, equals(1));
        expect(result.tags.first.id, equals('test-tag-id'));
        expect(result.tags.first.name, equals('Test Tag'));
      });

      test('should handle null optional fields', () {
        final json = {...jsonMap}
          ..remove('description')
          ..remove('tags');
        final result = TagGroupModel.fromJson(json);
        expect(result.description, isNull);
        expect(result.tags, isEmpty);
      });

      test('should handle missing fields with defaults', () {
        final json = <String, dynamic>{};
        final result = TagGroupModel.fromJson(json);
        expect(result.id, equals(''));
        expect(result.name, equals(''));
      });
    });

    group('toJson', () {
      test('should return a valid JSON map', () {
        final model = TagGroupModel.fromJson(jsonMap);
        final result = model.toJson();
        expect(result['id'], equals('test-tag-group-id'));
        expect(result['name'], equals('Test Tag Group'));
        expect(result['description'], equals('A test tag group'));
        expect(result['tags'], isA<List>());
      });
    });

    group('equality', () {
      test('should be equal when fields match', () {
        final a = TagGroupModel.fromJson(jsonMap);
        final b = TagGroupModel.fromJson(jsonMap);
        expect(a, equals(b));
      });

      test('should not be equal when id differs', () {
        final a = TagGroupModel.fromJson(jsonMap);
        final b = TagGroupModel(
          id: 'different-id',
          name: a.name,
          description: a.description,
        );
        expect(a, isNot(equals(b)));
      });
    });
  });

  group('fromJsonList', () {
    test('should return empty list for null input', () {
      expect(TagGroupModel.fromJsonList(null), isEmpty);
    });

    test('should return empty list for empty input', () {
      expect(TagGroupModel.fromJsonList([]), isEmpty);
    });

    test('should parse list of tag groups', () {
      final result = TagGroupModel.fromJsonList([jsonMap]);
      expect(result.length, equals(1));
      expect(result.first.id, equals('test-tag-group-id'));
    });

    test('should skip non-map entries', () {
      final result = TagGroupModel.fromJsonList([jsonMap, 'invalid', 123]);
      expect(result.length, equals(1));
    });
  });
}
