// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'child_category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChildCategoryModel _$ChildCategoryModelFromJson(Map<String, dynamic> json) =>
    ChildCategoryModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      entities: (json['entities'] as List<dynamic>)
          .map((e) => $enumDecode(_$EntityTypeEnumMap, e))
          .toList(),
    );

Map<String, dynamic> _$ChildCategoryModelToJson(
  ChildCategoryModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'entities': instance.entities.map((e) => _$EntityTypeEnumMap[e]!).toList(),
};

const _$EntityTypeEnumMap = {
  EntityType.city: 'city',
  EntityType.event: 'event',
  EntityType.business: 'business',
};
