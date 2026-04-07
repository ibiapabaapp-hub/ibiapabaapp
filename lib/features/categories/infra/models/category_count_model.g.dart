// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_count_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CategoryCountModel _$CategoryCountModelFromJson(Map<String, dynamic> json) =>
    _CategoryCountModel(
      cities: (json['city'] as num).toInt(),
      companies: (json['company_category'] as num).toInt(),
      events: (json['event_category'] as num).toInt(),
      children: (json['children'] as num).toInt(),
    );

Map<String, dynamic> _$CategoryCountModelToJson(_CategoryCountModel instance) =>
    <String, dynamic>{
      'city': instance.cities,
      'company_category': instance.companies,
      'event_category': instance.events,
      'children': instance.children,
    };
