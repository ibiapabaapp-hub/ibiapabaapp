import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:ibiapabaapp/features/accounts/infra/models/interest_model.dart';
import '../../../../fixtures/fixture_reader.dart';

void main() {
  final jsonString = fixture('interest.json');
  final jsonMap = json.decode(jsonString) as Map<String, dynamic>;

  group('InterestModel', () {
    group('fromJson', () {
      test('should return a valid model from JSON', () {
        final result = InterestModel.fromJson(jsonMap);
        expect(result, isA<InterestModel>());
        expect(result.id, equals('test-interest-id'));
        expect(result.name, equals('Test Interest'));
      });
    });

    group('toJson', () {
      test('should return a valid JSON map', () {
        final model = InterestModel.fromJson(jsonMap);
        final result = model.toJson();
        expect(result['id'], equals('test-interest-id'));
        expect(result['name'], equals('Test Interest'));
      });
    });

    group('equality', () {
      test('should be equal when fields match', () {
        final a = InterestModel.fromJson(jsonMap);
        final b = InterestModel.fromJson(jsonMap);
        expect(a, equals(b));
      });

      test('should not be equal when name differs', () {
        final a = InterestModel.fromJson(jsonMap);
        final b = InterestModel(id: a.id, name: 'Different Name');
        expect(a, isNot(equals(b)));
      });
    });
  });
}
