import 'package:ibiapabaapp/core/errors/failures/failures.dart';

class UserNotFoundFailure extends AppFailure {
  const UserNotFoundFailure({required super.message})
    : super(code: 'user_not_found');
}

class WrongPasswordFailure extends AppFailure {
  const WrongPasswordFailure({required super.message})
    : super(code: 'wrong_password');
}

class EmailAlreadyRegisteredFailure extends AppFailure {
  const EmailAlreadyRegisteredFailure({required super.message})
    : super(code: 'email_already_registered');
}

class PasswordMismatchFailure extends AppFailure {
  const PasswordMismatchFailure({required super.message})
    : super(code: 'password_mismatch');
}

class InvalidTokenFailure extends AppFailure {
  const InvalidTokenFailure({required super.message})
    : super(code: 'invalid_token');
}
