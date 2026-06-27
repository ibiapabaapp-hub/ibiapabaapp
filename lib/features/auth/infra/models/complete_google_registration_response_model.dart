import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ibiapabaapp/features/accounts/infra/models/account_model.dart';
import '../../domain/entities/complete_google_registration.dart';

part 'complete_google_registration_response_model.g.dart';

@JsonSerializable()
class CompleteGoogleRegistrationResponseModel extends Equatable {
  @JsonKey(name: 'access_token')
  final String accessToken;

  @JsonKey(name: 'refresh_token')
  final String refreshToken;

  final AccountModel account;

  const CompleteGoogleRegistrationResponseModel({
    required this.accessToken,
    required this.refreshToken,
    required this.account,
  });

  factory CompleteGoogleRegistrationResponseModel.fromJson(
    Map<String, dynamic> json,
  ) => _$CompleteGoogleRegistrationResponseModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CompleteGoogleRegistrationResponseModelToJson(this);

  CompleteGoogleRegistrationResponse toEntity() {
    return CompleteGoogleRegistrationResponse(
      accessToken: accessToken,
      refreshToken: refreshToken,
      account: account,
    );
  }

  @override
  List<Object?> get props => [accessToken, refreshToken, account];
}
