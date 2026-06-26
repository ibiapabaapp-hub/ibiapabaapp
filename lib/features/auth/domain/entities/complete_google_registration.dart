import 'package:ibiapabaapp/core/storage/token_response.dart';
import 'package:ibiapabaapp/shared/models/account.dart';
import 'package:ibiapabaapp/shared/models/account_type.dart';
import 'package:ibiapabaapp/shared/models/gender.dart';

class CompleteGoogleRegistrationRequest {
  final String tempToken;
  final String slug;
  final AccountType type;
  final Gender? gender;

  CompleteGoogleRegistrationRequest({
    required this.tempToken,
    required this.slug,
    required this.type,
    this.gender,
  });
}

class CompleteGoogleRegistrationResponse implements TokenResponse {
  @override
  final String accessToken;
  @override
  final String refreshToken;
  final Account account;

  CompleteGoogleRegistrationResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.account,
  });
}
