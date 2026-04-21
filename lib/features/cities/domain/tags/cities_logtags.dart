import 'package:ibiapabaapp/core/logger/log_tags.dart';

enum CityAction implements LogTag {
  getAllCities('[GET_ALL_CITIES]'),
  getCityById('[GET_CITY_BY_ID]'),
  getCityMedia('[GET_CITY_MEDIA]');

  @override
  final String tag;
  const CityAction(this.tag);
}