import 'package:ibiapabaapp/core/storage/token_response.dart';
import 'package:ibiapabaapp/shared/models/account.dart';

class AuthResult implements TokenResponse {
  @override
  final String accessToken;
  @override
  final String refreshToken;
  final Account account;

  AuthResult({
    required this.accessToken,
    required this.refreshToken,
    required this.account,
  });
}
