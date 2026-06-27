import 'package:ibivibe/shared/models/city.dart';
import 'package:latlong2/latlong.dart';

class LocationData {
  final City? currentCity;
  final LatLng? devicePosition;

  LocationData({this.currentCity, this.devicePosition});

  LocationData copyWith({
    City? currentCity,
    LatLng? devicePosition,
    bool clearCity = false,
  }) {
    return LocationData(
      currentCity: clearCity ? null : (currentCity ?? this.currentCity),
      devicePosition: devicePosition ?? this.devicePosition,
    );
  }
}
