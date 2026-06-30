import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ibivibe/features/accounts/models/account_interests_response.dart';

part 'account_interests_response_model.g.dart';

@JsonSerializable()
class AccountInterestsResponseModel extends Equatable
    implements AccountInterestsResponse {
  @override
  final int count;

  const AccountInterestsResponseModel({required this.count});

  factory AccountInterestsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AccountInterestsResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$AccountInterestsResponseModelToJson(this);

  static Map<String, dynamic> toMap(
    AccountInterestsResponse accountInterestsResponse,
  ) => {'count': accountInterestsResponse.count};

  @override
  List<Object?> get props => [count];
}
