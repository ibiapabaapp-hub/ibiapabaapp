import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ibivibe/features/accounts/infra/models/account_business_model.dart';
import 'package:ibivibe/features/accounts/infra/models/account_interests_model.dart';
import 'package:ibivibe/features/accounts/infra/models/converters/account_type_converter.dart';
import 'package:ibivibe/features/accounts/infra/models/converters/gender_converter.dart';
import 'package:ibivibe/shared/models/account.dart';
import 'package:ibivibe/shared/models/account_type.dart';
import 'package:ibivibe/shared/models/gender.dart';

part 'account_model.g.dart';

@JsonSerializable()
class AccountModel extends Equatable implements Account {
  @override
  final String id;

  @override
  final String email;

  @override
  @JsonKey(name: 'phone_number')
  final String? phoneNumber;

  @override
  final String name;

  @override
  final bool active;

  @override
  @JsonKey(name: 'is_verified')
  final bool isVerified;

  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @override
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  @override
  final String slug;

  @override
  @JsonKey(name: 'display_name')
  final String displayName;

  @override
  final String? bio;

  @override
  @JsonKey(name: 'avatar_url')
  final String? avatarUrl;

  @override
  @AccountTypeConverter()
  final AccountType type;

  @override
  final AccountInterestsModel? interests;

  @override
  final AccountBusinessModel? business;

  @override
  @GenderConverter()
  final Gender? gender;

  const AccountModel({
    required this.id,
    required this.email,
    this.phoneNumber,
    required this.name,
    required this.active,
    required this.isVerified,
    required this.createdAt,
    required this.updatedAt,
    required this.slug,
    required this.displayName,
    this.bio,
    this.avatarUrl,
    required this.type,
    this.interests,
    this.business,
    this.gender,
  });

  factory AccountModel.fromJson(Map<String, dynamic> json) =>
      _$AccountModelFromJson(json);

  Map<String, dynamic> toJson() => _$AccountModelToJson(this);

  static List<Account> fromJsonList(dynamic jsonList) {
    if (jsonList == null) return [];
    return (jsonList as List<dynamic>)
        .map((json) => AccountModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  static Map<String, dynamic> toMap(Account account) {
    if (account is AccountModel) return account.toJson();
    return {
      'id': account.id,
      'email': account.email,
      'phone_number': account.phoneNumber,
      'name': account.name,
      'active': account.active,
      'is_verified': account.isVerified,
      'created_at': account.createdAt.toIso8601String(),
      'updated_at': account.updatedAt.toIso8601String(),
      'slug': account.slug,
      'display_name': account.displayName,
      'bio': account.bio,
      'avatar_url': account.avatarUrl,
      'type': account.type.value,
      if (account.gender != null) 'gender': account.gender!.value,
      if (account.interests != null)
        'interests': AccountInterestsModel.toMap(account.interests!),
      if (account.business != null)
        'business': AccountBusinessModel.toMap(account.business!),
    };
  }

  @override
  List<Object?> get props => [
    id,
    email,
    phoneNumber,
    name,
    active,
    isVerified,
    createdAt,
    updatedAt,
    slug,
    displayName,
    bio,
    avatarUrl,
    type,
    interests,
    business,
    gender,
  ];
}
