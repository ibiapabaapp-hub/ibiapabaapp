// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'google_auth_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoogleAuthResultModel _$GoogleAuthResultModelFromJson(
  Map<String, dynamic> json,
) => GoogleAuthResultModel(
  isNewUser: json['is_new_user'] as bool,
  tempToken: json['temp_token'] as String?,
  avatarUrl: json['avatar_url'] as String?,
  account: json['account'] == null
      ? null
      : AccountModel.fromJson(json['account'] as Map<String, dynamic>),
  accessToken: json['access_token'] as String?,
  refreshToken: json['refresh_token'] as String?,
);

Map<String, dynamic> _$GoogleAuthResultModelToJson(
  GoogleAuthResultModel instance,
) => <String, dynamic>{
  'is_new_user': instance.isNewUser,
  'temp_token': instance.tempToken,
  'avatar_url': instance.avatarUrl,
  'account': instance.account,
  'access_token': instance.accessToken,
  'refresh_token': instance.refreshToken,
};
