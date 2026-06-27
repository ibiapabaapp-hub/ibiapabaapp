import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:ibivibe/features/accounts/infra/models/account_model.dart';
import '../../../../fixtures/fixture_reader.dart';

void main() {
  final jsonString = fixture('account.json');
  final jsonMap = json.decode(jsonString) as Map<String, dynamic>;

  group('AccountModel', () {
    group('fromJson', () {
      test('should return a valid model from JSON', () {
        final result = AccountModel.fromJson(jsonMap);
        expect(result, isA<AccountModel>());
        expect(result.id, equals('test-account-id'));
        expect(result.email, equals('test@example.com'));
        expect(result.phoneNumber, equals('+5511999999999'));
        expect(result.name, equals('Test User'));
        expect(result.active, isTrue);
        expect(result.isVerified, isTrue);
        expect(result.slug, equals('test-user'));
        expect(result.displayName, equals('Test User'));
        expect(result.bio, equals('A test user account'));
        expect(result.avatarUrl, equals('https://example.com/avatar.jpg'));
        expect(result.gender, isNotNull);
      });

      test('should handle null optional fields', () {
        final json = {...jsonMap}
          ..remove('phone_number')
          ..remove('bio')
          ..remove('avatar_url')
          ..remove('gender');
        final result = AccountModel.fromJson(json);
        expect(result.phoneNumber, isNull);
        expect(result.bio, isNull);
        expect(result.avatarUrl, isNull);
        expect(result.gender, isNull);
      });

      test('should parse DateTime fields correctly', () {
        final result = AccountModel.fromJson(jsonMap);
        expect(result.createdAt, isA<DateTime>());
        expect(result.updatedAt, isA<DateTime>());
      });
    });

    group('toJson', () {
      test('should return a valid JSON map', () {
        final model = AccountModel.fromJson(jsonMap);
        final result = model.toJson();
        expect(result['id'], equals('test-account-id'));
        expect(result['email'], equals('test@example.com'));
        expect(result['phone_number'], equals('+5511999999999'));
        expect(result['is_verified'], isTrue);
        expect(result['display_name'], equals('Test User'));
        expect(result['created_at'], isA<String>());
        expect(result['updated_at'], isA<String>());
      });
    });

    group('equality', () {
      test('should be equal when fields match', () {
        final a = AccountModel.fromJson(jsonMap);
        final b = AccountModel.fromJson(jsonMap);
        expect(a, equals(b));
      });

      test('should not be equal when id differs', () {
        final a = AccountModel.fromJson(jsonMap);
        final b = AccountModel(
          id: 'different-id',
          email: a.email,
          name: a.name,
          active: a.active,
          isVerified: a.isVerified,
          createdAt: a.createdAt,
          updatedAt: a.updatedAt,
          slug: a.slug,
          displayName: a.displayName,
          type: a.type,
        );
        expect(a, isNot(equals(b)));
      });
    });
  });
}
