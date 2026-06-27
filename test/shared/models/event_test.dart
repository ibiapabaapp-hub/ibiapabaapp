import 'package:flutter_test/flutter_test.dart';
import 'package:ibiapabaapp/shared/models/business.dart';
import 'package:ibiapabaapp/shared/models/event.dart';

Event _createEvent({
  String id = '1',
  String name = 'Test Event',
  String slug = 'test-event',
  EventType type = EventType.simple,
  ReachLevel reachLevel = ReachLevel.local,
}) {
  return Event(
    id: id,
    ownerAccountId: 'owner-1',
    slug: slug,
    name: name,
    type: type,
    reachLevel: reachLevel,
    categories: [],
    startDate: DateTime(2025),
    endDate: DateTime(2025, 12),
    createdAt: DateTime(2025),
    updatedAt: DateTime(2025),
  );
}

void main() {
  group('Event', () {
    group('constructor', () {
      test('should create event with required fields', () {
        final event = _createEvent();

        expect(event.id, '1');
        expect(event.ownerAccountId, 'owner-1');
        expect(event.name, 'Test Event');
        expect(event.slug, 'test-event');
        expect(event.type, EventType.simple);
        expect(event.reachLevel, ReachLevel.local);
        expect(event.categories, isEmpty);
      });

      test('should allow null optional fields', () {
        final event = _createEvent();

        expect(event.description, isNull);
        expect(event.coverImgUrl, isNull);
      });

      test('should accept optional fields', () {
        final event = Event(
          id: '1',
          ownerAccountId: 'owner-1',
          slug: 'test',
          name: 'Test',
          description: 'A description',
          type: EventType.featured,
          reachLevel: ReachLevel.regional,
          coverImgUrl: 'https://example.com/cover.png',
          categories: ['music'],
          startDate: DateTime(2025),
          endDate: DateTime(2025, 12),
          createdAt: DateTime(2025),
          updatedAt: DateTime(2025),
        );

        expect(event.description, 'A description');
        expect(event.type, EventType.featured);
        expect(event.reachLevel, ReachLevel.regional);
        expect(event.coverImgUrl, 'https://example.com/cover.png');
        expect(event.categories, ['music']);
      });
    });

    group('equality', () {
      test('same instance should be equal to itself', () {
        final event = _createEvent();
        expect(event, equals(event));
      });

      test('different instances with same fields should not be equal', () {
        final a = _createEvent();
        final b = _createEvent();
        expect(a, isNot(equals(b)));
      });

      test('should not be equal when id differs', () {
        final a = _createEvent(id: '1');
        final b = _createEvent(id: '2');
        expect(a, isNot(equals(b)));
      });

      test('should not be equal when name differs', () {
        final a = _createEvent(name: 'Event A');
        final b = _createEvent(name: 'Event B');
        expect(a, isNot(equals(b)));
      });
    });
  });

  group('EventType', () {
    test('should have simple and featured values', () {
      expect(EventType.simple, isNotNull);
      expect(EventType.featured, isNotNull);
    });
  });
}
