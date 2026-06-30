import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'auth_result.dart';
import '../../accounts/models/account_model.dart';

part 'auth_result_model.g.dart';

@JsonSerializable()
class AuthResultModel extends Equatable implements AuthResult {
  @override
  @JsonKey(name: 'access_token')
  final String accessToken;

  @override
  @JsonKey(name: 'refresh_token')
  final String refreshToken;

  @override
  final AccountModel account;

  const AuthResultModel({
    required this.accessToken,
    required this.refreshToken,
    required this.account,
  });

  factory AuthResultModel.fromJson(Map<String, dynamic> json) =>
      _$AuthResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResultModelToJson(this);

  @override
  List<Object?> get props => [accessToken, refreshToken, account];
}
