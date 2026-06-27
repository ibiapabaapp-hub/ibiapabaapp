import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:ibivibe/features/accounts/infra/models/account_interests_response_model.dart';
import '../../../../fixtures/fixture_reader.dart';

void main() {
  final jsonString = fixture('account_interests_response.json');
  final jsonMap = json.decode(jsonString) as Map<String, dynamic>;

  group('AccountInterestsResponseModel', () {
    group('fromJson', () {
      test('should return a valid model from JSON', () {
        final result = AccountInterestsResponseModel.fromJson(jsonMap);
        expect(result, isA<AccountInterestsResponseModel>());
        expect(result.count, equals(5));
      });

      test('should handle zero count', () {
        final json = <String, dynamic>{'count': 0};
        final result = AccountInterestsResponseModel.fromJson(json);
        expect(result.count, equals(0));
      });
    });

    group('toJson', () {
      test('should return a valid JSON map', () {
        final model = AccountInterestsResponseModel.fromJson(jsonMap);
        final result = model.toJson();
        expect(result['count'], equals(5));
      });
    });

    group('equality', () {
      test('should be equal when fields match', () {
        final a = AccountInterestsResponseModel.fromJson(jsonMap);
        final b = AccountInterestsResponseModel.fromJson(jsonMap);
        expect(a, equals(b));
      });

      test('should not be equal when count differs', () {
        final a = AccountInterestsResponseModel.fromJson(jsonMap);
        final b = const AccountInterestsResponseModel(count: 10);
        expect(a, isNot(equals(b)));
      });
    });
  });
}
