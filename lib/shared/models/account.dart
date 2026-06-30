import 'package:ibivibe/shared/models/account_type.dart';
import 'package:ibivibe/features/accounts/models/account_business.dart';
import 'package:ibivibe/features/accounts/models/account_interests.dart';
import 'package:ibivibe/shared/models/gender.dart';

class Account {
  // Authentication fields
  final String id;
  final String email;
  final String? phoneNumber;
  final String name;
  final bool active;
  final bool isVerified;
  final DateTime createdAt;
  final DateTime updatedAt;

  final String slug;
  final String displayName;
  final String? bio;
  final String? avatarUrl;
  final AccountType type;
  final AccountInterests? interests;
  final AccountBusiness? business;
  final Gender? gender;

  Account({
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
}
