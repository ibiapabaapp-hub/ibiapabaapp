// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BusinessModel _$BusinessModelFromJson(Map<String, dynamic> json) =>
    _BusinessModel(
      id: json['id'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
      cnpj: json['cnpj'] as String?,
      name: json['name'] as String? ?? '',
      bio: json['bio'] as String?,
      avatar: json['avatar'] as String?,
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

Map<String, dynamic> _$BusinessModelToJson(_BusinessModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'slug': instance.slug,
      'cnpj': instance.cnpj,
      'name': instance.name,
      'bio': instance.bio,
      'avatar': instance.avatar,
      'max_reach_level': _$ReachLevelEnumMap[instance.maxReachLevel]!,
      'cover_img_url': instance.coverImgUrl,
      'categories': instance.categories,
      'created_at': instance.createdAt.toIso8601String(),
    };

const _$ReachLevelEnumMap = {
  ReachLevel.local: 'local',
  ReachLevel.regional: 'regional',
};
