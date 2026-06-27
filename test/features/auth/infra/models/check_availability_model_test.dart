import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:ibivibe/features/auth/domain/entities/check_availability.dart';
import 'package:ibivibe/features/auth/infra/models/check_availability_model.dart';
import '../../../../fixtures/fixture_reader.dart';

void main() {
  final jsonString = fixture('check_availability.json');
  final jsonMap = json.decode(jsonString) as Map<String, dynamic>;

  group('CheckAvailabilityModel', () {
    group('fromJson', () {
      test('should return a valid model from JSON', () {
        final result = CheckAvailabilityModel.fromJson(jsonMap);
        expect(result, isA<CheckAvailabilityModel>());
        expect(result.field, equals(AvailabilityField.email));
        expect(result.value, equals('test@example.com'));
        expect(result.available, isTrue);
      });

      test('should deserialize field from slug string', () {
        final json = {...jsonMap, 'field': 'slug'};
        final result = CheckAvailabilityModel.fromJson(json);
        expect(result.field, equals(AvailabilityField.slug));
      });

      test('should deserialize field from phone_number string', () {
        final json = {...jsonMap, 'field': 'phone_number'};
        final result = CheckAvailabilityModel.fromJson(json);
        expect(result.field, equals(AvailabilityField.phoneNumber));
      });
    });

    group('toJson', () {
      test('should return a valid JSON map', () {
        final model = CheckAvailabilityModel.fromJson(jsonMap);
        final result = model.toJson();
        expect(result['field'], equals('email'));
        expect(result['value'], equals('test@example.com'));
        expect(result['available'], isTrue);
      });

      test('should serialize phoneNumber field to phone_number', () {
        final model = const CheckAvailabilityModel(
          field: AvailabilityField.phoneNumber,
          value: '+5511999999999',
          available: true,
        );
        final result = model.toJson();
        expect(result['field'], equals('phone_number'));
      });
    });

    group('equality', () {
      test('should be equal when fields match', () {
        final a = CheckAvailabilityModel.fromJson(jsonMap);
        final b = CheckAvailabilityModel.fromJson(jsonMap);
        expect(a, equals(b));
      });

      test('should not be equal when available differs', () {
        final a = CheckAvailabilityModel.fromJson(jsonMap);
        final b = CheckAvailabilityModel(
          field: a.field,
          value: a.value,
          available: false,
        );
        expect(a, isNot(equals(b)));
      });
    });
  });
}
