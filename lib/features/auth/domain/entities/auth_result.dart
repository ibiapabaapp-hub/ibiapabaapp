import 'package:ibiapabaapp/core/storage/token_response.dart';
import 'package:ibiapabaapp/features/auth/domain/entities/user.dart';

class AuthResult implements TokenResponse {
  @override
  final String accessToken;
  @override
  final String refreshToken;
  final User user;

  AuthResult({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });
}