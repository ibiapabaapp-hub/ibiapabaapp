import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:ibivibe/features/cities/infra/models/cities_model.dart';
import '../../../../fixtures/fixture_reader.dart';

void main() {
  final jsonString = fixture('city.json');
  final jsonMap = json.decode(jsonString) as Map<String, dynamic>;

  group('CityModel', () {
    group('fromJson', () {
      test('should return a valid model from JSON', () {
        final result = CityModel.fromJson(jsonMap);
        expect(result, isA<CityModel>());
        expect(result.id, equals('test-city-id'));
        expect(result.name, equals('Test City'));
        expect(result.slug, equals('test-city'));
        expect(result.description, equals('A test city'));
        expect(result.coverImgUrl, equals('https://example.com/city.jpg'));
        expect(result.categories, equals(['tourism', 'culture']));
        expect(result.location, isNotNull);
      });

      test('should handle null optional fields', () {
        final json = {...jsonMap}
          ..remove('description')
          ..remove('cover_img_url')
          ..remove('location');
        final result = CityModel.fromJson(json);
        expect(result.description, isNull);
        expect(result.coverImgUrl, isNull);
        expect(result.location, isNull);
      });

      test('should handle missing fields with defaults', () {
        final json = <String, dynamic>{};
        final result = CityModel.fromJson(json);
        expect(result.id, equals(''));
        expect(result.name, equals(''));
        expect(result.slug, equals(''));
        expect(result.categories, isEmpty);
      });
    });

    group('toJson', () {
      test('should return a valid JSON map', () {
        final model = CityModel.fromJson(jsonMap);
        final result = model.toJson();
        expect(result['id'], equals('test-city-id'));
        expect(result['name'], equals('Test City'));
        expect(result['categories'], isA<List>());
      });
    });

    group('equality', () {
      test('should be equal when fields match', () {
        final a = CityModel.fromJson(jsonMap);
        final b = CityModel.fromJson(jsonMap);
        expect(a, equals(b));
      });

      test('should not be equal when name differs', () {
        final a = CityModel.fromJson(jsonMap);
        final b = CityModel(
          id: a.id,
          name: 'Different City',
          slug: a.slug,
          categories: a.categories,
        );
        expect(a, isNot(equals(b)));
      });
    });
  });
}
