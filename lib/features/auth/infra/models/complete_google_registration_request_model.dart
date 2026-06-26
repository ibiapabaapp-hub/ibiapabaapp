import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ibiapabaapp/shared/models/account_type.dart';
import 'package:ibiapabaapp/shared/models/gender.dart';

part 'complete_google_registration_request_model.freezed.dart';
part 'complete_google_registration_request_model.g.dart';

@freezed
abstract class CompleteGoogleRegistrationRequestModel
    with _$CompleteGoogleRegistrationRequestModel {
  const CompleteGoogleRegistrationRequestModel._();

  const factory CompleteGoogleRegistrationRequestModel({
    @JsonKey(name: 'temp_token') required String tempToken,
    required String slug,
    required String type,
    String? gender,
  }) = _CompleteGoogleRegistrationRequestModel;

  factory CompleteGoogleRegistrationRequestModel.fromJson(
    Map<String, dynamic> json,
  ) => _$CompleteGoogleRegistrationRequestModelFromJson(json);

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
}
