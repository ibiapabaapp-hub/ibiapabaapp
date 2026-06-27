import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:ibiapabaapp/features/auth/infra/models/complete_google_registration_request_model.dart';
import '../../../../fixtures/fixture_reader.dart';

void main() {
  final jsonString = fixture('complete_google_registration_request.json');
  final jsonMap = json.decode(jsonString) as Map<String, dynamic>;

  group('CompleteGoogleRegistrationRequestModel', () {
    group('fromJson', () {
      test('should return a valid model from JSON', () {
        final result = CompleteGoogleRegistrationRequestModel.fromJson(jsonMap);
        expect(result, isA<CompleteGoogleRegistrationRequestModel>());
        expect(result.tempToken, equals('temp-token-123'));
        expect(result.slug, equals('test-user'));
        expect(result.type, equals('personal'));
        expect(result.gender, equals('male'));
      });

      test('should handle null optional gender field', () {
        final json = {...jsonMap}..remove('gender');
        final result = CompleteGoogleRegistrationRequestModel.fromJson(json);
        expect(result.gender, isNull);
      });
    });

    group('toJson', () {
      test('should return a valid JSON map', () {
        final model =
            CompleteGoogleRegistrationRequestModel.fromJson(jsonMap);
        final result = model.toJson();
        expect(result['temp_token'], equals('temp-token-123'));
        expect(result['slug'], equals('test-user'));
        expect(result['type'], equals('personal'));
        expect(result['gender'], equals('male'));
      });
    });

    group('equality', () {
      test('should be equal when fields match', () {
        final a = CompleteGoogleRegistrationRequestModel.fromJson(jsonMap);
        final b = CompleteGoogleRegistrationRequestModel.fromJson(jsonMap);
        expect(a, equals(b));
      });

      test('should not be equal when slug differs', () {
        final a = CompleteGoogleRegistrationRequestModel.fromJson(jsonMap);
        final b = CompleteGoogleRegistrationRequestModel(
          tempToken: a.tempToken,
          slug: 'different-slug',
          type: a.type,
          gender: a.gender,
        );
        expect(a, isNot(equals(b)));
      });
    });
  });
}
