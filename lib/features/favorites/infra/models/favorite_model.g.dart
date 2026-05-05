// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FavoriteModel _$FavoriteModelFromJson(Map<String, dynamic> json) =>
    _FavoriteModel(
      id: json['id'] as String?,
      profileId: json['profile_id'] as String,
      cityId: json['city_id'] as String?,
      businessProfileId: json['business_profile_id'] as String?,
      eventId: json['event_id'] as String?,
    );

Map<String, dynamic> _$FavoriteModelToJson(_FavoriteModel instance) =>
    <String, dynamic>{
      'id': ?instance.id,
      'profile_id': instance.profileId,
      'city_id': instance.cityId,
      'business_profile_id': instance.businessProfileId,
      'event_id': instance.eventId,
    };
