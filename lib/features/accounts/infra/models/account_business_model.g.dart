// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_business_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountBusinessModel _$AccountBusinessModelFromJson(
  Map<String, dynamic> json,
) => AccountBusinessModel(
  name: json['name'] as String?,
  document: json['document'] as String?,
  description: json['description'] as String?,
  website: json['website'] as String?,
  address: json['address'] as String?,
  phone: json['phone'] as String?,
  category: json['category'] as String?,
);

Map<String, dynamic> _$AccountBusinessModelToJson(
  AccountBusinessModel instance,
) => <String, dynamic>{
  'name': instance.name,
  'document': instance.document,
  'description': instance.description,
  'website': instance.website,
  'address': instance.address,
  'phone': instance.phone,
  'category': instance.category,
};
