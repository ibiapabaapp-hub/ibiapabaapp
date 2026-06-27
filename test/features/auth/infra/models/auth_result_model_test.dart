import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:ibiapabaapp/features/auth/infra/models/auth_result_model.dart';
import 'package:ibiapabaapp/features/accounts/infra/models/account_model.dart';
import '../../../../fixtures/fixture_reader.dart';

void main() {
  final jsonString = fixture('auth_result.json');
  final jsonMap = json.decode(jsonString) as Map<String, dynamic>;

  group('AuthResultModel', () {
    group('fromJson', () {
      test('should return a valid model from JSON', () {
        final result = AuthResultModel.fromJson(jsonMap);
        expect(result, isA<AuthResultModel>());
        expect(result.accessToken, equals('test-access-token'));
        expect(result.refreshToken, equals('test-refresh-token'));
        expect(result.account.id, equals('test-account-id'));
      });

      test('should handle nested account correctly', () {
        final result = AuthResultModel.fromJson(jsonMap);
        expect(result.account.email, equals('test@example.com'));
        expect(result.account.name, equals('Test User'));
      });
    });

    group('toJson', () {
      test('should return a valid JSON map', () {
        final model = AuthResultModel.fromJson(jsonMap);
        final result = model.toJson();
        expect(result['access_token'], equals('test-access-token'));
        expect(result['refresh_token'], equals('test-refresh-token'));
        expect(result['account'], isA<AccountModel>());
      });
    });

    group('equality', () {
      test('should be equal when fields match', () {
        final a = AuthResultModel.fromJson(jsonMap);
        final b = AuthResultModel.fromJson(jsonMap);
        expect(a, equals(b));
      });

      test('should not be equal when access token differs', () {
        final a = AuthResultModel.fromJson(jsonMap);
        final b = AuthResultModel(
          accessToken: 'different-token',
          refreshToken: a.refreshToken,
          account: a.account,
        );
        expect(a, isNot(equals(b)));
      });
    });
  });
}
