import 'package:ibiapabaapp/features/auth/validation/auth_validator.dart';
import 'package:ibiapabaapp/shared/models/account_type.dart';
import 'package:ibiapabaapp/features/accounts/domain/entities/account_business.dart';

class RegisterFormData {
  String name;
  String slug;
  String displayName;
  String email;
  String phoneNumber;
  String password;
  String confirmPassword;
  String? bio;
  String? avatarUrl;
  AccountType type;
  AccountBusiness? businessData; // Only if type == business

  RegisterFormData({
    this.name = '',
    this.slug = '',
    this.displayName = '',
    this.email = '',
    this.phoneNumber = '',
    this.password = '',
    this.confirmPassword = '',
    this.bio,
    this.avatarUrl,
    this.type = AccountType.personal,
    this.businessData,
  });

  factory RegisterFormData.fromMap(Map<String, dynamic> map) {
    return RegisterFormData(
      name: map[AuthFields.name.name] ?? '',
      slug: map['slug'] ?? '',
      displayName: map['display_name'] ?? '',
      email: map[AuthFields.email.name] ?? '',
      phoneNumber: map[AuthFields.phoneNumber.name] ?? '',
      password: map[AuthFields.password.name] ?? '',
      confirmPassword: map[AuthFields.confirmPassword.name] ?? '',
      bio: map['bio'],
      avatarUrl: map['avatar_url'],
      type: map['type'] != null
          ? AccountType.fromString(map['type'])
          : AccountType.personal,
      businessData: map['business_data'] != null
          ? AccountBusiness(
              name: map['business_data']['name'],
              document: map['business_data']['document'],
              description: map['business_data']['description'],
              website: map['business_data']['website'],
              address: map['business_data']['address'],
              phone: map['business_data']['phone'],
              category: map['business_data']['category'],
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'slug': slug,
      'display_name': displayName,
      'email': email,
      'phone_number': phoneNumber,
      'password': password,
      'password_confirm': confirmPassword,
      'bio': bio,
      'avatar_url': avatarUrl,
      'type': type.value,
      if (businessData != null)
        'business_data': {
          'name': businessData!.name,
          'document': businessData!.document,
          'description': businessData!.description,
          'website': businessData!.website,
          'address': businessData!.address,
          'phone': businessData!.phone,
          'category': businessData!.category,
        },
    };
  }

  RegisterFormData copyWith({
    String? name,
    String? slug,
    String? displayName,
    String? email,
    String? phoneNumber,
    String? password,
    String? confirmPassword,
    String? bio,
    String? avatarUrl,
    AccountType? type,
    AccountBusiness? businessData,
  }) {
    return RegisterFormData(
      name: name ?? this.name,
      slug: slug ?? this.slug,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      bio: bio ?? this.bio,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      type: type ?? this.type,
      businessData: businessData ?? this.businessData,
    );
  }

  RegisterFormData copyWithField(AuthFields field, dynamic value) {
    switch (field) {
      case AuthFields.name:
        return copyWith(name: value);
      case AuthFields.email:
        return copyWith(email: value);
      case AuthFields.phoneNumber:
        return copyWith(phoneNumber: value);
      case AuthFields.password:
        return copyWith(password: value);
      case AuthFields.confirmPassword:
        return copyWith(confirmPassword: value);
      default:
        return this;
    }
  }
}
