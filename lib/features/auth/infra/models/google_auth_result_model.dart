import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ibivibe/features/accounts/infra/models/account_model.dart';
import '../../domain/entities/google_auth_result.dart';

part 'google_auth_result_model.g.dart';

@JsonSerializable()
class GoogleAuthResultModel extends Equatable {
  @JsonKey(name: 'is_new_user')
  final bool isNewUser;

  @JsonKey(name: 'temp_token')
  final String? tempToken;

  @JsonKey(name: 'avatar_url')
  final String? avatarUrl;

  final AccountModel? account;

  @JsonKey(name: 'access_token')
  final String? accessToken;

  @JsonKey(name: 'refresh_token')
  final String? refreshToken;

  const GoogleAuthResultModel({
    required this.isNewUser,
    this.tempToken,
    this.avatarUrl,
    this.account,
    this.accessToken,
    this.refreshToken,
  });

  factory GoogleAuthResultModel.fromJson(Map<String, dynamic> json) =>
      _$GoogleAuthResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$GoogleAuthResultModelToJson(this);

  GoogleAuthResult toEntity() {
    return GoogleAuthResult(
      isNewUser: isNewUser,
      tempToken: tempToken,
      account: account,
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }

  @override
  List<Object?> get props => [
    isNewUser,
    tempToken,
    avatarUrl,
    account,
    accessToken,
    refreshToken,
  ];
}
