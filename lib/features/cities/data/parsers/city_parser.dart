import 'package:ibiapabaapp/features/cities/domain/entities/city.dart';
import 'package:latlong2/latlong.dart';

class CityParser {
  static City fromJson(Map<String, dynamic> json) {
    LatLng? location;

    if (json['location'] != null && json['location']['coordinates'] != null) {
      final List<dynamic> coordinates = json['location']['coordinates'];
      final double lng = (coordinates[0] as num).toDouble();
      final double lat = (coordinates[1] as num).toDouble();
      location = LatLng(lat, lng);
    }

    return City(
      id: json['id'].toString(),
      name: json['name'],
      slug: json['slug'],
      coverImgUrl: json['coverImgUrl'] ?? '',
      description: json['description'] as String?,
      categories:
          (json['categories'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      location: location,
    );
  }

  static List<City> fromJsonList(dynamic jsonList) {
    if (jsonList == null) return [];
    final list = jsonList as List<dynamic>;
    return list.map((json) => fromJson(json as Map<String, dynamic>)).toList();
  }

  static Map<String, dynamic> toMap(City city) {
    return {
      'id': city.id,
      'name': city.name,
      'slug': city.slug,
      'coverImgUrl': city.coverImgUrl,
      'description': city.description,
      'categories': city.categories,
      'location': city.location != null
          ? {
              'coordinates': [
                city.location!.longitude,
                city.location!.latitude,
              ],
            }
          : null,
    };
  }
}
