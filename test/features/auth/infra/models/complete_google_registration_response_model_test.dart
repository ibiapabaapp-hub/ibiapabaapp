import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:ibivibe/features/auth/models/complete_google_registration_response_model.dart';
import 'package:ibivibe/features/accounts/models/account_model.dart';
import '../../../../fixtures/fixture_reader.dart';

void main() {
  final jsonString = fixture('complete_google_registration_response.json');
  final jsonMap = json.decode(jsonString) as Map<String, dynamic>;

  group('CompleteGoogleRegistrationResponseModel', () {
    group('fromJson', () {
      test('should return a valid model from JSON', () {
        final result =
            CompleteGoogleRegistrationResponseModel.fromJson(jsonMap);
        expect(result, isA<CompleteGoogleRegistrationResponseModel>());
        expect(result.accessToken, equals('test-access-token'));
        expect(result.refreshToken, equals('test-refresh-token'));
        expect(result.account.id, equals('test-account-id'));
      });

      test('should handle nested account correctly', () {
        final result =
            CompleteGoogleRegistrationResponseModel.fromJson(jsonMap);
        expect(result.account.email, equals('test@example.com'));
      });
    });

    group('toJson', () {
      test('should return a valid JSON map', () {
        final model =
            CompleteGoogleRegistrationResponseModel.fromJson(jsonMap);
        final result = model.toJson();
        expect(result['access_token'], equals('test-access-token'));
        expect(result['refresh_token'], equals('test-refresh-token'));
        expect(result['account'], isA<AccountModel>());
      });
    });

    group('equality', () {
      test('should be equal when fields match', () {
        final a = CompleteGoogleRegistrationResponseModel.fromJson(jsonMap);
        final b = CompleteGoogleRegistrationResponseModel.fromJson(jsonMap);
        expect(a, equals(b));
      });

      test('should not be equal when access token differs', () {
        final a = CompleteGoogleRegistrationResponseModel.fromJson(jsonMap);
        final b = CompleteGoogleRegistrationResponseModel(
          accessToken: 'different-token',
          refreshToken: a.refreshToken,
          account: a.account,
        );
        expect(a, isNot(equals(b)));
      });
    });
  });
}
