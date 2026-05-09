import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ibiapabaapp/features/accounts/infra/models/account_business_model.dart';
import 'package:ibiapabaapp/features/accounts/infra/models/account_interests_model.dart';
import 'package:ibiapabaapp/features/accounts/infra/models/converters/account_type_converter.dart';
import 'package:ibiapabaapp/features/accounts/infra/models/converters/gender_converter.dart';
import '../../domain/entities/account.dart';
import '../../domain/entities/account_type.dart';
import '../../domain/entities/gender.dart';

part 'account_model.freezed.dart';
part 'account_model.g.dart';

@freezed
abstract class AccountModel with _$AccountModel implements Account {
  const factory AccountModel({
    required String id,
    required String email,
    @JsonKey(name: 'phone_number') String? phoneNumber,
    required String name,
    required bool active,
    @JsonKey(name: 'is_verified') required bool isVerified,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
    required String slug,
    @JsonKey(name: 'display_name') required String displayName,
    String? bio,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @AccountTypeConverter() required AccountType type,
    AccountInterestsModel? interests,
    AccountBusinessModel? business,
    @GenderConverter() Gender? gender,
  }) = _AccountModel;

  factory AccountModel.fromJson(Map<String, dynamic> json) =>
      _$AccountModelFromJson(json);

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
}
