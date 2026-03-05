import 'package:latlong2/latlong.dart';

import '../../domain/entities/city.dart';

class CityParser {
  static City fromJson(Map<String, dynamic> json) {
    final geoJson = json['location'];
    final List<dynamic> coordinates = geoJson['coordinates'];

    final double lng = coordinates[0].toDouble();
    final double lat = coordinates[1].toDouble();

    return City(
      id: json['id'] as String,
      name: json['name'] as String,
      slug: json['slug'] as String,
      imageUrl: json['image_url'] as String,
      description: json['description'] as String?,
      categories:
          (json['categories'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      location: LatLng(lat, lng),
    );
  }

  static List<City> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
