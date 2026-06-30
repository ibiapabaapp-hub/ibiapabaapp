import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ibivibe/shared/models/account_type.dart';
import 'package:ibivibe/shared/models/gender.dart';

part 'complete_google_registration_request_model.g.dart';

@JsonSerializable()
class CompleteGoogleRegistrationRequestModel extends Equatable {
  @JsonKey(name: 'temp_token')
  final String tempToken;

  final String slug;

  final String type;

  final String? gender;

  const CompleteGoogleRegistrationRequestModel({
    required this.tempToken,
    required this.slug,
    required this.type,
    this.gender,
  });

  factory CompleteGoogleRegistrationRequestModel.fromJson(
    Map<String, dynamic> json,
  ) => _$CompleteGoogleRegistrationRequestModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CompleteGoogleRegistrationRequestModelToJson(this);

  static CompleteGoogleRegistrationRequestModel fromDomain({
    required String tempToken,
    required String slug,
    required AccountType type,
    Gender? gender,
  }) {
    return CompleteGoogleRegistrationRequestModel(
      tempToken: tempToken,
      slug: slug,
      type: type.value,
      gender: gender?.value,
    );
  }

  @override
  List<Object?> get props => [tempToken, slug, type, gender];
}
