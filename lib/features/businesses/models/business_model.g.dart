// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BusinessModel _$BusinessModelFromJson(Map<String, dynamic> json) =>
    BusinessModel(
      id: json['id'] as String? ?? '',
      profileId: json['profile_id'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
      cnpj: json['cnpj'] as String?,
      name: json['name'] as String? ?? '',
      bio: json['bio'] as String?,
      avatar: json['avatar_url'] as String?,
      maxReachLevel: $enumDecode(
        _$ReachLevelEnumMap,
        json['max_reach_level'],
        unknownValue: ReachLevel.local,
      ),
      coverImgUrl: json['cover_img_url'] as String?,
      categories:
          (json['categories'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$BusinessModelToJson(BusinessModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'profile_id': instance.profileId,
      'slug': instance.slug,
      'cnpj': instance.cnpj,
      'name': instance.name,
      'bio': instance.bio,
      'avatar_url': instance.avatar,
      'max_reach_level': _$ReachLevelEnumMap[instance.maxReachLevel]!,
      'cover_img_url': instance.coverImgUrl,
      'categories': instance.categories,
      'created_at': instance.createdAt.toIso8601String(),
    };

const _$ReachLevelEnumMap = {
  ReachLevel.local: 'local',
  ReachLevel.regional: 'regional',
};
