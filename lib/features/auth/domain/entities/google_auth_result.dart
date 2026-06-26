import 'package:ibiapabaapp/shared/models/account.dart';

class GoogleAuthResult {
  final bool isNewUser;
  final Account? account;
  final String? tempToken;
  final String? accessToken;
  final String? refreshToken;

  GoogleAuthResult({
    required this.isNewUser,
    this.tempToken,
    this.account,
    this.accessToken,
    this.refreshToken,
  });
}
