// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EventModel _$EventModelFromJson(Map<String, dynamic> json) => _EventModel(
  id: json['id'] as String,
  slug: json['slug'] as String,
  name: json['name'] as String,
  userId: json['userId'] as String?,
  companyId: json['companyId'] as String?,
  description: json['description'] as String?,
  type: $enumDecode(
    _$EventTypeEnumMap,
    json['type'],
    unknownValue: EventType.simple,
  ),
  reachLevel: $enumDecode(_$ReachLevelEnumMap, json['reachLevel']),
  coverImgUrl: json['coverImgUrl'] as String?,
  categories:
      (json['categories'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  startDate: DateTime.parse(json['startDate'] as String),
  endDate: DateTime.parse(json['endDate'] as String),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$EventModelToJson(_EventModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'slug': instance.slug,
      'name': instance.name,
      'userId': instance.userId,
      'companyId': instance.companyId,
      'description': instance.description,
      'type': _$EventTypeEnumMap[instance.type]!,
      'reachLevel': _$ReachLevelEnumMap[instance.reachLevel]!,
      'coverImgUrl': instance.coverImgUrl,
      'categories': instance.categories,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$EventTypeEnumMap = {
  EventType.simple: 'simple',
  EventType.featured: 'featured',
};

const _$ReachLevelEnumMap = {
  ReachLevel.local: 'local',
  ReachLevel.regional: 'regional',
};
