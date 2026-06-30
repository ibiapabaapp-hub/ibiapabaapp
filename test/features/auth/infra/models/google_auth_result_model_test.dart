import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:ibivibe/features/auth/models/google_auth_result_model.dart';
import '../../../../fixtures/fixture_reader.dart';

void main() {
  final jsonString = fixture('google_auth_result.json');
  final jsonMap = json.decode(jsonString) as Map<String, dynamic>;

  group('GoogleAuthResultModel', () {
    group('fromJson', () {
      test('should return a valid model from JSON', () {
        final result = GoogleAuthResultModel.fromJson(jsonMap);
        expect(result, isA<GoogleAuthResultModel>());
        expect(result.isNewUser, isTrue);
        expect(result.tempToken, equals('temp-token-123'));
        expect(result.avatarUrl, equals('https://example.com/avatar.jpg'));
        expect(result.accessToken, equals('test-access-token'));
        expect(result.refreshToken, equals('test-refresh-token'));
        expect(result.account, isNotNull);
      });

      test('should handle null optional fields', () {
        final json = {...jsonMap}
          ..remove('temp_token')
          ..remove('avatar_url')
          ..remove('account')
          ..remove('access_token')
          ..remove('refresh_token');
        final result = GoogleAuthResultModel.fromJson(json);
        expect(result.tempToken, isNull);
        expect(result.avatarUrl, isNull);
        expect(result.account, isNull);
        expect(result.accessToken, isNull);
        expect(result.refreshToken, isNull);
      });
    });

    group('toJson', () {
      test('should return a valid JSON map', () {
        final model = GoogleAuthResultModel.fromJson(jsonMap);
        final result = model.toJson();
        expect(result['is_new_user'], isTrue);
        expect(result['temp_token'], equals('temp-token-123'));
        expect(result['access_token'], equals('test-access-token'));
      });
    });

    group('equality', () {
      test('should be equal when fields match', () {
        final a = GoogleAuthResultModel.fromJson(jsonMap);
        final b = GoogleAuthResultModel.fromJson(jsonMap);
        expect(a, equals(b));
      });

      test('should not be equal when isNewUser differs', () {
        final a = GoogleAuthResultModel.fromJson(jsonMap);
        final b = GoogleAuthResultModel(
          isNewUser: false,
          tempToken: a.tempToken,
          avatarUrl: a.avatarUrl,
          account: a.account,
          accessToken: a.accessToken,
          refreshToken: a.refreshToken,
        );
        expect(a, isNot(equals(b)));
      });
    });
  });
}
