// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AccountModel _$AccountModelFromJson(Map<String, dynamic> json) =>
    _AccountModel(
      id: json['id'] as String,
      email: json['email'] as String,
      phoneNumber: json['phone_number'] as String?,
      name: json['name'] as String,
      active: json['active'] as bool,
      isVerified: json['is_verified'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      slug: json['slug'] as String,
      displayName: json['display_name'] as String,
      bio: json['bio'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      type: const AccountTypeConverter().fromJson(json['type'] as String),
      interests: json['interests'] == null
          ? null
          : AccountInterestsModel.fromJson(
              json['interests'] as Map<String, dynamic>,
            ),
      business: json['business'] == null
          ? null
          : AccountBusinessModel.fromJson(
              json['business'] as Map<String, dynamic>,
            ),
      gender: _$JsonConverterFromJson<String, Gender>(
        json['gender'],
        const GenderConverter().fromJson,
      ),
    );

Map<String, dynamic> _$AccountModelToJson(_AccountModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'phone_number': instance.phoneNumber,
      'name': instance.name,
      'active': instance.active,
      'is_verified': instance.isVerified,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'slug': instance.slug,
      'display_name': instance.displayName,
      'bio': instance.bio,
      'avatar_url': instance.avatarUrl,
      'type': const AccountTypeConverter().toJson(instance.type),
      'interests': instance.interests,
      'business': instance.business,
      'gender': _$JsonConverterToJson<String, Gender>(
        instance.gender,
        const GenderConverter().toJson,
      ),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);
