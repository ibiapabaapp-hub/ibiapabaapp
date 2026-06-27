import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:ibivibe/features/accounts/infra/models/account_interests_model.dart';
import '../../../../fixtures/fixture_reader.dart';

void main() {
  final jsonString = fixture('account_interests.json');
  final jsonMap = json.decode(jsonString) as Map<String, dynamic>;

  group('AccountInterestsModel', () {
    group('fromJson', () {
      test('should return a valid model from JSON', () {
        final result = AccountInterestsModel.fromJson(jsonMap);
        expect(result, isA<AccountInterestsModel>());
        expect(result.businesses, hasLength(2));
        expect(result.events, hasLength(1));
        expect(result.businesses[0].id, equals('b1'));
        expect(result.events[0].name, equals('Event 1'));
      });

      test('should handle null optional list fields', () {
        final json = <String, dynamic>{'businesses': null, 'events': null};
        final result = AccountInterestsModel.fromJson(json);
        expect(result.businesses, isEmpty);
        expect(result.events, isEmpty);
      });

      test('should handle empty lists', () {
        final json = <String, dynamic>{'businesses': [], 'events': []};
        final result = AccountInterestsModel.fromJson(json);
        expect(result.businesses, isEmpty);
        expect(result.events, isEmpty);
      });
    });

    group('toJson', () {
      test('should return a valid JSON map', () {
        final model = AccountInterestsModel.fromJson(jsonMap);
        final result = model.toJson();
        expect(result['businesses'], isA<List>());
        expect(result['events'], isA<List>());
        expect((result['businesses'] as List), hasLength(2));
      });
    });

    group('equality', () {
      test('should be equal when fields match', () {
        final a = AccountInterestsModel.fromJson(jsonMap);
        final b = AccountInterestsModel.fromJson(jsonMap);
        expect(a, equals(b));
      });

      test('should not be equal when businesses differ', () {
        final a = AccountInterestsModel.fromJson(jsonMap);
        final b = AccountInterestsModel(
          businesses: [],
          events: a.events,
        );
        expect(a, isNot(equals(b)));
      });
    });
  });
}
