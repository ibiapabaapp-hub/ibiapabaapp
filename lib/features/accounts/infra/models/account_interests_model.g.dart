// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_interests_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountInterestsModel _$AccountInterestsModelFromJson(
  Map<String, dynamic> json,
) => AccountInterestsModel(
  businesses:
      (json['businesses'] as List<dynamic>?)
          ?.map((e) => InterestModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  events:
      (json['events'] as List<dynamic>?)
          ?.map((e) => InterestModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$AccountInterestsModelToJson(
  AccountInterestsModel instance,
) => <String, dynamic>{
  'businesses': instance.businesses,
  'events': instance.events,
};
