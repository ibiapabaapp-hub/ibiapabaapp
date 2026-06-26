import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ibiapabaapp/shared/models/city.dart';
import 'package:ibiapabaapp/shared/utils/lat_lng_converter.dart';
import 'package:latlong2/latlong.dart';

part 'cities_model.g.dart';

Object? _readCoverImgUrl(Map json, String key) =>
    json['cover_img_url'] ?? json['coverImgUrl'];

@JsonSerializable()
class CityModel extends Equatable implements City {
  @override
  final String id;
  @override
  final String name;
  @override
  final String slug;
  @override
  final String? description;
  @override
  @JsonKey(readValue: _readCoverImgUrl)
  final String? coverImgUrl;
  @override
  final List<String> categories;
  @override
  @LatLngConverter()
  final LatLng? location;

  const CityModel({
    this.id = '',
    this.name = '',
    this.slug = '',
    this.description,
    this.coverImgUrl,
    this.categories = const [],
    this.location,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) =>
      _$CityModelFromJson(json);

  Map<String, dynamic> toJson() => _$CityModelToJson(this);

  static List<City> fromJsonList(dynamic jsonList) {
    if (jsonList == null) return [];
    final list = jsonList as List<dynamic>;
    return list
        .map((json) => CityModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  static Map<String, dynamic> toMap(City city) {
    if (city is CityModel) return city.toJson();
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

  @override
  List<Object?> get props => [
        id,
        name,
        slug,
        description,
        coverImgUrl,
        categories,
        location,
      ];
}
