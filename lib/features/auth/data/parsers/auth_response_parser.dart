import 'package:ibiapabaapp/features/auth/domain/entities/auth_result.dart';
import 'package:ibiapabaapp/features/auth/domain/entities/user.dart';

class AuthResponseParser {
  static AuthResult fromJson(Map<String, dynamic> json) {
    return AuthResult(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
      user: _userFromJson(json['user'] as Map<String, dynamic>),
    );
  }

  static User _userFromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      username: json['username'] as String,
      role: json['role'] as String,
      active: json['active'] as bool,
    );
  }
}
