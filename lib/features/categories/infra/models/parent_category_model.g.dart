// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ParentCategoryModel _$ParentCategoryModelFromJson(Map<String, dynamic> json) =>
    _ParentCategoryModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      count: CategoryCountModel.fromJson(
        json['_count'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$ParentCategoryModelToJson(
  _ParentCategoryModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  '_count': instance.count,
};
