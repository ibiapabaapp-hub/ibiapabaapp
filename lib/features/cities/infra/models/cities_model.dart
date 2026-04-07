import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ibiapabaapp/features/cities/domain/entities/city.dart';
import 'package:ibiapabaapp/shared/utils/lat_lng_converter.dart';
import 'package:latlong2/latlong.dart';

part 'cities_model.freezed.dart';
part 'cities_model.g.dart';

Object? _readCoverImgUrl(Map json, String key) =>
    json['cover_img_url'] ?? json['coverImgUrl'];

@freezed
abstract class CityModel with _$CityModel implements City {
  const CityModel._();

  const factory CityModel({
    @Default('') String id,
    @Default('') String name,
    @Default('') String slug,
    String? description,
    @JsonKey(readValue: _readCoverImgUrl) @Default('') String? coverImgUrl,
    @Default([]) List<String> categories,
    @LatLngConverter() LatLng? location,
  }) = _CityModel;

  factory CityModel.fromJson(Map<String, dynamic> json) =>
      _$CityModelFromJson(json);

  static List<City> fromJsonList(dynamic jsonList) {
    if (jsonList == null) return [];
    final list = jsonList as List<dynamic>;
    return list
        .map((json) => CityModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  static Map<String, dynamic> toMap(City city) {
    if (city is CityModel) {
      return city.toJson();
    }
    return CityModel(
      id: city.id,
      name: city.name,
      slug: city.slug,
      coverImgUrl: city.coverImgUrl,
      description: city.description,
      categories: city.categories,
      location: city.location,
    ).toJson();
  }
}


