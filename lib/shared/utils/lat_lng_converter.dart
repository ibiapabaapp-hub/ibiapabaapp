import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

class LatLngConverter implements JsonConverter<LatLng?, dynamic> {
  const LatLngConverter();

  @override
  LatLng? fromJson(dynamic json) {
    if (json is Map<String, dynamic> && json['coordinates'] != null) {
      final List<dynamic> coordinates = json['coordinates'];
      final double lng = (coordinates[0] as num).toDouble();
      final double lat = (coordinates[1] as num).toDouble();
      return LatLng(lat, lng);
    }
    return null;
  }

  @override
  dynamic toJson(LatLng? object) {
    if (object == null) return null;
    return {
      'coordinates': [object.longitude, object.latitude],
    };
  }
}
