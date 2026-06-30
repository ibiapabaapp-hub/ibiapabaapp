import 'package:latlong2/latlong.dart';

class City {
  final String id;
  final String name;
  final String slug;
  final String? description;
  final String? coverImgUrl;
  final List<String> tags;
  final LatLng? location;

  City({
    required this.id,
    required this.name,
    required this.slug,
    this.description,
    required this.tags,
    this.location,
    this.coverImgUrl,
  });
}
