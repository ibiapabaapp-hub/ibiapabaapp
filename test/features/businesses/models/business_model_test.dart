import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:ibivibe/features/businesses/models/business_model.dart';
import 'package:ibivibe/shared/models/business.dart';
import '../../../fixtures/fixture_reader.dart';

void main() {
  final jsonString = fixture('business.json');
  final jsonMap = json.decode(jsonString) as Map<String, dynamic>;

  group('BusinessModel', () {
    group('fromJson', () {
      test('should return a valid model from JSON', () {
        final result = BusinessModel.fromJson(jsonMap);
        expect(result, isA<BusinessModel>());
        expect(result.id, equals('test-business-id'));
        expect(result.name, equals('Test Business'));
        expect(result.slug, equals('test-business'));
        expect(result.bio, equals('A test business'));
        expect(result.avatar, equals('https://example.com/avatar.jpg'));
        expect(result.maxReachLevel, equals(ReachLevel.local));
        expect(result.categories, equals(['food', 'services']));
        expect(result.createdAt, isA<DateTime>());
      });

      test('should handle null optional fields', () {
        final json = {...jsonMap}
          ..remove('bio')
          ..remove('avatar_url')
          ..remove('cover_img_url')
          ..remove('cnpj');
        final result = BusinessModel.fromJson(json);
        expect(result.bio, isNull);
        expect(result.avatar, isNull);
        expect(result.coverImgUrl, isNull);
        expect(result.cnpj, isNull);
      });

      test('should handle missing profile_id with default', () {
        final json = {...jsonMap}..remove('profile_id');
        final result = BusinessModel.fromJson(json);
        expect(result.profileId, equals(''));
      });
    });

    group('toJson', () {
      test('should return a valid JSON map', () {
        final model = BusinessModel.fromJson(jsonMap);
        final result = model.toJson();
        expect(result['id'], equals('test-business-id'));
        expect(result['name'], equals('Test Business'));
        expect(result['max_reach_level'], equals('local'));
        expect(result['avatar_url'], equals('https://example.com/avatar.jpg'));
        expect(result['created_at'], isA<String>());
      });
    });

    group('equality', () {
      test('should be equal when fields match', () {
        final a = BusinessModel.fromJson(jsonMap);
        final b = BusinessModel.fromJson(jsonMap);
        expect(a, equals(b));
      });

      test('should not be equal when id differs', () {
        final a = BusinessModel.fromJson(jsonMap);
        final b = BusinessModel(
          id: 'different-id',
          name: a.name,
          slug: a.slug,
          maxReachLevel: a.maxReachLevel,
          createdAt: a.createdAt,
        );
        expect(a, isNot(equals(b)));
      });
    });
  });
}
