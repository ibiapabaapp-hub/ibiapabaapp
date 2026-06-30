import 'package:flutter_test/flutter_test.dart';
import 'package:ibivibe/shared/models/city.dart';
import 'package:latlong2/latlong.dart';

City _createCity({
  String id = '1',
  String name = 'São Paulo',
  String slug = 'sao-paulo',
}) {
  return City(
    id: id,
    name: name,
    slug: slug,
    tags: [],
  );
}

void main() {
  group('City', () {
    group('constructor', () {
      test('should create city with required fields', () {
        final city = _createCity();

        expect(city.id, '1');
        expect(city.name, 'São Paulo');
        expect(city.slug, 'sao-paulo');
        expect(city.tags, isEmpty);
      });

      test('should allow null optional fields', () {
        final city = _createCity();

        expect(city.description, isNull);
        expect(city.coverImgUrl, isNull);
        expect(city.location, isNull);
      });

      test('should accept optional fields', () {
        final city = City(
          id: '1',
          name: 'Recife',
          slug: 'recife',
          description: 'Venice of Brazil',
          tags: ['beach'],
          location: const LatLng(-8.05, -34.87),
          coverImgUrl: 'https://example.com/recife.png',
        );

        expect(city.description, 'Venice of Brazil');
        expect(city.tags, ['beach']);
        expect(city.location, const LatLng(-8.05, -34.87));
        expect(city.coverImgUrl, 'https://example.com/recife.png');
      });
    });

    group('equality', () {
      test('same instance should be equal to itself', () {
        final city = _createCity();
        expect(city, equals(city));
      });

      test('different instances with same fields should not be equal', () {
        final a = _createCity();
        final b = _createCity();
        expect(a, isNot(equals(b)));
      });

      test('should not be equal when id differs', () {
        final a = _createCity(id: '1');
        final b = _createCity(id: '2');
        expect(a, isNot(equals(b)));
      });

      test('should not be equal when name differs', () {
        final a = _createCity(name: 'São Paulo');
        final b = _createCity(name: 'Recife');
        expect(a, isNot(equals(b)));
      });

      test('should not be equal when slug differs', () {
        final a = _createCity(slug: 'sao-paulo');
        final b = _createCity(slug: 'recife');
        expect(a, isNot(equals(b)));
      });
    });
  });
}
