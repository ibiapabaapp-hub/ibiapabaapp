// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CompanyModel _$CompanyModelFromJson(Map<String, dynamic> json) =>
    _CompanyModel(
      id: json['id'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
      cnpj: json['cnpj'] as String?,
      name: json['name'] as String? ?? '',
      description: json['description'] as String?,
      maxReachLevel: $enumDecode(
        _$ReachLevelEnumMap,
        json['maxReachLevel'],
        unknownValue: ReachLevel.local,
      ),
      coverImgUrl: json['coverImgUrl'] as String?,
      categories:
          (json['categories'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$CompanyModelToJson(_CompanyModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'slug': instance.slug,
      'cnpj': instance.cnpj,
      'name': instance.name,
      'description': instance.description,
      'maxReachLevel': _$ReachLevelEnumMap[instance.maxReachLevel]!,
      'coverImgUrl': instance.coverImgUrl,
      'categories': instance.categories,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$ReachLevelEnumMap = {
  ReachLevel.local: 'local',
  ReachLevel.regional: 'regional',
};
