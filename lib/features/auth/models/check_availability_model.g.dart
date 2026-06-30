// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_availability_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckAvailabilityModel _$CheckAvailabilityModelFromJson(
  Map<String, dynamic> json,
) => CheckAvailabilityModel(
  field: _availabilityFieldFromApi(json['field'] as String),
  value: json['value'] as String,
  available: json['available'] as bool,
);

Map<String, dynamic> _$CheckAvailabilityModelToJson(
  CheckAvailabilityModel instance,
) => <String, dynamic>{
  'field': _availabilityFieldToApi(instance.field),
  'value': instance.value,
  'available': instance.available,
};
