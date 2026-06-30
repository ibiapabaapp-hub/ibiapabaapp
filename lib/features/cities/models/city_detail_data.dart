import 'package:ibivibe/shared/models/city.dart';
import 'package:ibivibe/shared/models/media.dart';

class CityDetailData {
  final City city;
  final List<Media> media;
  const CityDetailData({required this.city, required this.media});
}
