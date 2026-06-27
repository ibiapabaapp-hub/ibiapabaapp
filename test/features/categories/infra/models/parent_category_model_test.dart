import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:ibiapabaapp/features/categories/infra/models/parent_category_model.dart';
import '../../../../fixtures/fixture_reader.dart';

void main() {
  final jsonString = fixture('parent_category.json');
  final jsonMap = json.decode(jsonString) as Map<String, dynamic>;

  group('ParentCategoryModel', () {
    group('fromJson', () {
      test('should return a valid model from JSON', () {
        final result = ParentCategoryModel.fromJson(jsonMap);
        expect(result, isA<ParentCategoryModel>());
        expect(result.id, equals('test-parent-category-id'));
        expect(result.name, equals('Test Parent Category'));
        expect(result.entities, hasLength(2));
        expect(result.children, isNotNull);
        expect(result.children, hasLength(1));
        expect(result.children![0].id, equals('test-child-category-id'));
      });

      test('should handle null children', () {
        final json = {...jsonMap}..remove('children');
        final result = ParentCategoryModel.fromJson(json);
        expect(result.children, isNull);
      });

      test('should handle empty children list', () {
        final json = {...jsonMap, 'children': <Map<String, dynamic>>[]};
        final result = ParentCategoryModel.fromJson(json);
        expect(result.children, isEmpty);
      });
    });

    group('toJson', () {
      test('should return a valid JSON map', () {
        final model = ParentCategoryModel.fromJson(jsonMap);
        final result = model.toJson();
        expect(result['id'], equals('test-parent-category-id'));
        expect(result['name'], equals('Test Parent Category'));
        expect(result['entities'], isA<List>());
        expect(result['children'], isA<List>());
      });
    });

    group('equality', () {
      test('should be equal when fields match', () {
        final a = ParentCategoryModel.fromJson(jsonMap);
        final b = ParentCategoryModel.fromJson(jsonMap);
        expect(a, equals(b));
      });

      test('should not be equal when name differs', () {
        final a = ParentCategoryModel.fromJson(jsonMap);
        final b = ParentCategoryModel(
          id: a.id,
          name: 'Different Name',
          entities: a.entities,
          children: a.children,
        );
        expect(a, isNot(equals(b)));
      });
    });
  });
}
