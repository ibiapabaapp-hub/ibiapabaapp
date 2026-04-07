// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_interest_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserInterestModel _$UserInterestModelFromJson(Map<String, dynamic> json) =>
    _UserInterestModel(
      companyIds:
          (json['companyIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      eventIds:
          (json['eventIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$UserInterestModelToJson(_UserInterestModel instance) =>
    <String, dynamic>{
      'companyIds': instance.companyIds,
      'eventIds': instance.eventIds,
    };
