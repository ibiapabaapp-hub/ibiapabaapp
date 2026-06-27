import 'package:flutter_test/flutter_test.dart';
import 'package:ibiapabaapp/shared/models/business.dart';

Business _createBusiness({
  String id = '1',
  String name = 'Test Business',
  String slug = 'test-business',
  ReachLevel maxReachLevel = ReachLevel.local,
}) {
  return Business(
    id: id,
    name: name,
    slug: slug,
    maxReachLevel: maxReachLevel,
    categories: [],
    createdAt: DateTime(2025),
  );
}

void main() {
  group('Business', () {
    group('constructor', () {
      test('should create business with required fields', () {
        final business = _createBusiness();

        expect(business.id, '1');
        expect(business.name, 'Test Business');
        expect(business.slug, 'test-business');
        expect(business.maxReachLevel, ReachLevel.local);
        expect(business.categories, isEmpty);
        expect(business.createdAt, DateTime(2025));
      });

      test('should allow null optional fields', () {
        final business = _createBusiness();

        expect(business.bio, isNull);
        expect(business.avatar, isNull);
      });

      test('should accept optional fields', () {
        final business = Business(
          id: '1',
          name: 'Café',
          slug: 'cafe',
          bio: 'Coffee shop',
          avatar: 'https://example.com/cafe.png',
          maxReachLevel: ReachLevel.regional,
          categories: ['food'],
          createdAt: DateTime(2025),
        );

        expect(business.bio, 'Coffee shop');
        expect(business.avatar, 'https://example.com/cafe.png');
        expect(business.maxReachLevel, ReachLevel.regional);
        expect(business.categories, ['food']);
      });
    });

    group('equality', () {
      test('same instance should be equal to itself', () {
        final business = _createBusiness();
        expect(business, equals(business));
      });

      test('different instances with same fields should not be equal', () {
        final a = _createBusiness();
        final b = _createBusiness();
        expect(a, isNot(equals(b)));
      });

      test('should not be equal when id differs', () {
        final a = _createBusiness(id: '1');
        final b = _createBusiness(id: '2');
        expect(a, isNot(equals(b)));
      });

      test('should not be equal when name differs', () {
        final a = _createBusiness(name: 'Business A');
        final b = _createBusiness(name: 'Business B');
        expect(a, isNot(equals(b)));
      });

      test('should not be equal when maxReachLevel differs', () {
        final a = _createBusiness(maxReachLevel: ReachLevel.local);
        final b = _createBusiness(maxReachLevel: ReachLevel.regional);
        expect(a, isNot(equals(b)));
      });
    });
  });

  group('ReachLevel', () {
    test('should have local and regional values', () {
      expect(ReachLevel.local, isNotNull);
      expect(ReachLevel.regional, isNotNull);
    });
  });
}
