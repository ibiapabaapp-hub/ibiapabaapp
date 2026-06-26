import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:ibiapabaapp/features/favorites/infra/models/favorite_model.dart';
import '../../../../fixtures/fixture_reader.dart';

void main() {
  final jsonString = fixture('favorite.json');
  final jsonMap = json.decode(jsonString) as Map<String, dynamic>;

  group('FavoriteModel', () {
    group('fromJson', () {
      test('should return a valid model from JSON', () {
        final result = FavoriteModel.fromJson(jsonMap);
        expect(result, isA<FavoriteModel>());
        expect(result.id, equals('test-favorite-id'));
        expect(result.accountId, equals('test-account-id'));
        expect(result.cityId, equals('test-city-id'));
        expect(result.eventId, isNull);
        expect(result.businessId, isNull);
      });

      test('should handle null optional fields', () {
        final json = <String, dynamic>{
          'account_id': 'test-account-id',
        };
        final result = FavoriteModel.fromJson(json);
        expect(result.id, isNull);
        expect(result.cityId, isNull);
        expect(result.businessId, isNull);
        expect(result.eventId, isNull);
      });

      test('should handle all fields present', () {
        final json = <String, dynamic>{
          'id': 'fav-1',
          'account_id': 'acc-1',
          'city_id': 'city-1',
          'business_id': 'biz-1',
          'event_id': 'evt-1',
        };
        final result = FavoriteModel.fromJson(json);
        expect(result.id, equals('fav-1'));
        expect(result.accountId, equals('acc-1'));
        expect(result.cityId, equals('city-1'));
        expect(result.businessId, equals('biz-1'));
        expect(result.eventId, equals('evt-1'));
      });
    });

    group('toMap', () {
      test('should return a valid JSON map', () {
        final model = FavoriteModel.fromJson(jsonMap);
        final result = FavoriteModel.toMap(model);
        expect(result['id'], equals('test-favorite-id'));
        expect(result['account_id'], equals('test-account-id'));
        expect(result['city_id'], equals('test-city-id'));
        expect(result['event_id'], isNull);
        expect(result['business_id'], isNull);
      });
    });

    group('equality', () {
      test('should be equal when fields match', () {
        final a = FavoriteModel.fromJson(jsonMap);
        final b = FavoriteModel.fromJson(jsonMap);
        expect(a, equals(b));
      });

      test('should not be equal when id differs', () {
        final a = FavoriteModel.fromJson(jsonMap);
        final b = FavoriteModel(
          id: 'different-id',
          accountId: a.accountId,
          cityId: a.cityId,
        );
        expect(a, isNot(equals(b)));
      });
    });
  });
}
