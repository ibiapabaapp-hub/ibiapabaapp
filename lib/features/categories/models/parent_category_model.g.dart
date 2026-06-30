// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParentCategoryModel _$ParentCategoryModelFromJson(Map<String, dynamic> json) =>
    ParentCategoryModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      entities: (json['entities'] as List<dynamic>)
          .map((e) => $enumDecode(_$EntityTypeEnumMap, e))
          .toList(),
      children: (json['children'] as List<dynamic>?)
          ?.map((e) => ChildCategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ParentCategoryModelToJson(
  ParentCategoryModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'entities': instance.entities.map((e) => _$EntityTypeEnumMap[e]!).toList(),
  'children': instance.children,
};

const _$EntityTypeEnumMap = {
  EntityType.city: 'city',
  EntityType.event: 'event',
  EntityType.business: 'business',
};
