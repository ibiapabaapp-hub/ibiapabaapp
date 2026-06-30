import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:ibivibe/features/categories/models/child_category_model.dart';
import '../../../fixtures/fixture_reader.dart';

void main() {
  final jsonString = fixture('child_category.json');
  final jsonMap = json.decode(jsonString) as Map<String, dynamic>;

  group('ChildCategoryModel', () {
    group('fromJson', () {
      test('should return a valid model from JSON', () {
        final result = ChildCategoryModel.fromJson(jsonMap);
        expect(result, isA<ChildCategoryModel>());
        expect(result.id, equals('test-child-category-id'));
        expect(result.name, equals('Test Child Category'));
        expect(result.entities, hasLength(1));
      });

      test('should handle empty entities list', () {
        final json = {...jsonMap, 'entities': <String>[]};
        final result = ChildCategoryModel.fromJson(json);
        expect(result.entities, isEmpty);
      });

      test('should handle missing id and name with defaults', () {
        final json = <String, dynamic>{'entities': ['city']};
        final result = ChildCategoryModel.fromJson(json);
        expect(result.id, equals(''));
        expect(result.name, equals(''));
      });
    });

    group('toJson', () {
      test('should return a valid JSON map', () {
        final model = ChildCategoryModel.fromJson(jsonMap);
        final result = model.toJson();
        expect(result['id'], equals('test-child-category-id'));
        expect(result['name'], equals('Test Child Category'));
        expect(result['entities'], isA<List>());
      });
    });

    group('equality', () {
      test('should be equal when fields match', () {
        final a = ChildCategoryModel.fromJson(jsonMap);
        final b = ChildCategoryModel.fromJson(jsonMap);
        expect(a, equals(b));
      });

      test('should not be equal when id differs', () {
        final a = ChildCategoryModel.fromJson(jsonMap);
        final b = ChildCategoryModel(
          id: 'different-id',
          name: a.name,
          entities: a.entities,
        );
        expect(a, isNot(equals(b)));
      });
    });
  });
}
