import 'package:ibiapabaapp/shared/models/city.dart';
import 'package:ibiapabaapp/shared/models/media.dart';

class CityDetailData {
  final City city;
  final List<Media> media;
  const CityDetailData({required this.city, required this.media});
}
