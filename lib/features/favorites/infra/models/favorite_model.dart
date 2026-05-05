import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ibiapabaapp/features/favorites/domain/entities/favorite.dart';

part 'favorite_model.freezed.dart';
part 'favorite_model.g.dart';

@freezed
abstract class FavoriteModel with _$FavoriteModel implements Favorite {
  const FavoriteModel._();

  const factory FavoriteModel({
    @JsonKey(name: 'id', includeIfNull: false) String? id,
    @JsonKey(name: 'profile_id') required String profileId,
    @JsonKey(name: 'city_id', defaultValue: null) String? cityId,
    @JsonKey(name: 'business_profile_id', defaultValue: null)
    String? businessProfileId,
    @JsonKey(name: 'event_id', defaultValue: null) String? eventId,
  }) = _FavoriteModel;

  factory FavoriteModel.fromJson(Map<String, dynamic> json) =>
      _$FavoriteModelFromJson(json);

  static List<Favorite> fromJsonList(dynamic jsonList) {
    if (jsonList == null) return [];
    return (jsonList as List<dynamic>)
        .map((json) => FavoriteModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  static Map<String, dynamic> toMap(Favorite favorite) {
    if (favorite is FavoriteModel) return favorite.toJson();
    return FavoriteModel(
      id: favorite.id,
      profileId: favorite.profileId,
      cityId: favorite.cityId,
      eventId: favorite.eventId,
      businessProfileId: favorite.businessProfileId,
    ).toJson();
  }
}
