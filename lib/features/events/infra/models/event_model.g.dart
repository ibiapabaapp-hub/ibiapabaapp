// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EventModel _$EventModelFromJson(Map<String, dynamic> json) => _EventModel(
  id: json['id'] as String,
  slug: json['slug'] as String,
  name: json['name'] as String,
  userId: json['user_id'] as String?,
  companyId: json['company_id'] as String?,
  description: json['description'] as String?,
  type: $enumDecode(
    _$EventTypeEnumMap,
    json['type'],
    unknownValue: EventType.simple,
  ),
  reachLevel: $enumDecode(
    _$ReachLevelEnumMap,
    json['reach_level'],
    unknownValue: ReachLevel.local,
  ),
  coverImgUrl: json['cover_img_url'] as String?,
  categories:
      (json['categories'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  startDate: DateTime.parse(json['start_date'] as String),
  endDate: DateTime.parse(json['end_date'] as String),
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$EventModelToJson(_EventModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'slug': instance.slug,
      'name': instance.name,
      'user_id': instance.userId,
      'company_id': instance.companyId,
      'description': instance.description,
      'type': _$EventTypeEnumMap[instance.type]!,
      'reach_level': _$ReachLevelEnumMap[instance.reachLevel]!,
      'cover_img_url': instance.coverImgUrl,
      'categories': instance.categories,
      'start_date': instance.startDate.toIso8601String(),
      'end_date': instance.endDate.toIso8601String(),
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };

const _$EventTypeEnumMap = {
  EventType.simple: 'simple',
  EventType.featured: 'featured',
};

const _$ReachLevelEnumMap = {
  ReachLevel.local: 'local',
  ReachLevel.regional: 'regional',
};
