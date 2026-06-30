// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag_group_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TagGroupModel _$TagGroupModelFromJson(Map<String, dynamic> json) =>
    TagGroupModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      description: json['description'] as String?,
      tags:
          (json['tags'] as List<dynamic>?)
              ?.map((e) => TagModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$TagGroupModelToJson(TagGroupModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'tags': instance.tags,
    };
