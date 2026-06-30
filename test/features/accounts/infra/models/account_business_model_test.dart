import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:ibivibe/features/accounts/models/account_business_model.dart';
import '../../../../fixtures/fixture_reader.dart';

void main() {
  final jsonString = fixture('account_business.json');
  final jsonMap = json.decode(jsonString) as Map<String, dynamic>;

  group('AccountBusinessModel', () {
    group('fromJson', () {
      test('should return a valid model from JSON', () {
        final result = AccountBusinessModel.fromJson(jsonMap);
        expect(result, isA<AccountBusinessModel>());
        expect(result.name, equals('Test Business'));
        expect(result.document, equals('12345678901'));
        expect(result.description, equals('A test business description'));
        expect(result.website, equals('https://example.com'));
        expect(result.address, equals('123 Main St'));
        expect(result.phone, equals('+5511999999999'));
        expect(result.category, equals('food'));
      });

      test('should handle all null optional fields', () {
        final json = <String, dynamic>{};
        final result = AccountBusinessModel.fromJson(json);
        expect(result.name, isNull);
        expect(result.document, isNull);
        expect(result.description, isNull);
        expect(result.website, isNull);
        expect(result.address, isNull);
        expect(result.phone, isNull);
        expect(result.category, isNull);
      });
    });

    group('toJson', () {
      test('should return a valid JSON map', () {
        final model = AccountBusinessModel.fromJson(jsonMap);
        final result = model.toJson();
        expect(result['name'], equals('Test Business'));
        expect(result['document'], equals('12345678901'));
        expect(result['website'], equals('https://example.com'));
      });
    });

    group('equality', () {
      test('should be equal when fields match', () {
        final a = AccountBusinessModel.fromJson(jsonMap);
        final b = AccountBusinessModel.fromJson(jsonMap);
        expect(a, equals(b));
      });

      test('should not be equal when name differs', () {
        final a = AccountBusinessModel.fromJson(jsonMap);
        const b = AccountBusinessModel(name: 'Different Name');
        expect(a, isNot(equals(b)));
      });
    });
  });
}
