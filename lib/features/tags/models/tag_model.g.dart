// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TagModel _$TagModelFromJson(Map<String, dynamic> json) => TagModel(
  id: json['id'] as String? ?? '',
  name: json['name'] as String? ?? '',
  slug: json['slug'] as String? ?? '',
  description: json['description'] as String?,
  color: json['color'] as String?,
  groupId: json['group_id'] as String,
  position: (json['position'] as num?)?.toInt() ?? 0,
  group: json['group'] == null
      ? null
      : TagGroupModel.fromJson(json['group'] as Map<String, dynamic>),
);

Map<String, dynamic> _$TagModelToJson(TagModel instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'slug': instance.slug,
  'description': instance.description,
  'color': instance.color,
  'group_id': instance.groupId,
  'position': instance.position,
  'group': instance.group,
};
