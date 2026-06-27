import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:ibiapabaapp/features/events/infra/models/event_model.dart';
import '../../../../fixtures/fixture_reader.dart';

void main() {
  final jsonString = fixture('event.json');
  final jsonMap = json.decode(jsonString) as Map<String, dynamic>;

  group('EventModel', () {
    group('fromJson', () {
      test('should return a valid model from JSON', () {
        final result = EventModel.fromJson(jsonMap);
        expect(result, isA<EventModel>());
        expect(result.id, equals('test-event-id'));
        expect(result.slug, equals('test-event'));
        expect(result.name, equals('Test Event'));
        expect(result.ownerAccountId, equals('test-owner-id'));
        expect(result.description, equals('A test event'));
        expect(result.categories, equals(['music', 'culture']));
        expect(result.startDate, isA<DateTime>());
        expect(result.endDate, isA<DateTime>());
        expect(result.createdAt, isA<DateTime>());
        expect(result.updatedAt, isA<DateTime>());
      });

      test('should handle null optional description', () {
        final json = {...jsonMap}..remove('description');
        final result = EventModel.fromJson(json);
        expect(result.description, isNull);
      });

      test('should handle null optional cover_img_url', () {
        final json = {...jsonMap}..remove('cover_img_url');
        final result = EventModel.fromJson(json);
        expect(result.coverImgUrl, isNull);
      });

      test('should handle empty categories', () {
        final json = {...jsonMap, 'categories': <String>[]};
        final result = EventModel.fromJson(json);
        expect(result.categories, isEmpty);
      });
    });

    group('toJson', () {
      test('should return a valid JSON map', () {
        final model = EventModel.fromJson(jsonMap);
        final result = model.toJson();
        expect(result['id'], equals('test-event-id'));
        expect(result['owner_account_id'], equals('test-owner-id'));
        expect(result['start_date'], isA<String>());
        expect(result['end_date'], isA<String>());
        expect(result['created_at'], isA<String>());
        expect(result['updated_at'], isA<String>());
      });
    });

    group('equality', () {
      test('should be equal when fields match', () {
        final a = EventModel.fromJson(jsonMap);
        final b = EventModel.fromJson(jsonMap);
        expect(a, equals(b));
      });

      test('should not be equal when id differs', () {
        final a = EventModel.fromJson(jsonMap);
        final b = EventModel(
          id: 'different-id',
          slug: a.slug,
          name: a.name,
          ownerAccountId: a.ownerAccountId,
          type: a.type,
          reachLevel: a.reachLevel,
          startDate: a.startDate,
          endDate: a.endDate,
          createdAt: a.createdAt,
          updatedAt: a.updatedAt,
        );
        expect(a, isNot(equals(b)));
      });
    });
  });
}
