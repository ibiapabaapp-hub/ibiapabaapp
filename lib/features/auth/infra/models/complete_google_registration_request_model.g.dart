// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'complete_google_registration_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompleteGoogleRegistrationRequestModel
_$CompleteGoogleRegistrationRequestModelFromJson(Map<String, dynamic> json) =>
    CompleteGoogleRegistrationRequestModel(
      tempToken: json['temp_token'] as String,
      slug: json['slug'] as String,
      type: json['type'] as String,
      gender: json['gender'] as String?,
    );

Map<String, dynamic> _$CompleteGoogleRegistrationRequestModelToJson(
  CompleteGoogleRegistrationRequestModel instance,
) => <String, dynamic>{
  'temp_token': instance.tempToken,
  'slug': instance.slug,
  'type': instance.type,
  'gender': instance.gender,
};
