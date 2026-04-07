// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'child_category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChildCategoryModel _$ChildCategoryModelFromJson(Map<String, dynamic> json) =>
    _ChildCategoryModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      count: CategoryCountModel.fromJson(
        json['_count'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$ChildCategoryModelToJson(_ChildCategoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      '_count': instance.count,
    };
