import 'package:ibivibe/core/errors/exceptions/exceptions.dart';

class UserNotFoundException extends AppException {
  const UserNotFoundException(super.message) : super(code: 'user_not_found');
}

class WrongPasswordException extends AppException {
  const WrongPasswordException(super.message) : super(code: 'wrong_password');
}

class EmailAlreadyRegisteredException extends AppException {
  const EmailAlreadyRegisteredException(super.message)
    : super(code: 'email_already_registered');
}

class PasswordMismatchException extends AppException {
  const PasswordMismatchException(super.message)
    : super(code: 'password_mismatch');
}

class InvalidTokenException extends AppException {
  const InvalidTokenException(super.message) : super(code: 'invalid_token');
}
