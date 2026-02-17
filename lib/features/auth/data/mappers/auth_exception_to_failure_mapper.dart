import 'package:ibiapabaapp/core/errors/exceptions/exceptions.dart';
import 'package:ibiapabaapp/core/errors/exceptions/global_exception_to_failure_mapper.dart';
import 'package:ibiapabaapp/core/errors/failures/failures.dart';
import 'package:ibiapabaapp/features/auth/data/exceptions/auth_exceptions.dart';
import 'package:ibiapabaapp/features/auth/domain/failures/auth_failures.dart';

class AuthExceptionToFailureMapper {
  static Failure map(Object error) {
    if (error is Failure) return error;

    if (error is AppException) {
      final failure =
          _AuthFailureRegistry.getByCode(error) ??
          _AuthFailureRegistry.getByType(error);
      if (failure != null) return failure;
    }
    try {
      return GlobalExceptionToFailureMapper.map(error);
    } catch (_) {
      return ServerFailure('Erro inesperado: ${error.toString()}');
    }
  }
}

typedef FailureFactory = Failure Function(AppException e);

class _AuthFailureRegistry {
  static const Map<String, String> _userMessageByCode = {
    'user_not_found': 'Usuário não encontrado. Verifique o e-mail.',
    'wrong_password': 'Senha incorreta. Verifique e tente novamente.',
    'invalid_credentials': 'Senha incorreta. Verifique e tente novamente.',
    'email_already_registered':
        'E-mail já cadastrado. Faça login ou use outro e-mail.',
    'password_mismatch': 'Senha e confirmação devem ser iguais.',
    'invalid_token': 'Sessão expirada ou inválida. Faça login novamente.',
  };

  static final Map<Type, String> _userMessageByType = {
    UserNotFoundException: 'Usuário não encontrado. Verifique o e-mail.',
    WrongPasswordException: 'Senha incorreta. Verifique e tente novamente.',
    EmailAlreadyRegisteredException:
        'E-mail já cadastrado. Faça login ou use outro e-mail.',
    PasswordMismatchException: 'Senha e confirmação devem ser iguais.',
    InvalidTokenException: 'Sessão expirada ou inválida. Faça login novamente.',
  };

  static String _displayMessage(AppException e) =>
      _userMessageByCode[e.code] ??
      _userMessageByType[e.runtimeType] ??
      e.message;

  static final Map<String, FailureFactory> _byCode = {
    'user_not_found': (e) => UserNotFoundFailure(message: _displayMessage(e)),
    'wrong_password': (e) => WrongPasswordFailure(message: _displayMessage(e)),
    'invalid_credentials': (e) =>
        WrongPasswordFailure(message: _displayMessage(e)),
    'email_already_registered': (e) =>
        EmailAlreadyRegisteredFailure(message: _displayMessage(e)),
    'password_mismatch': (e) =>
        PasswordMismatchFailure(message: _displayMessage(e)),
    'invalid_token': (e) => InvalidTokenFailure(message: _displayMessage(e)),
  };

  static final Map<Type, FailureFactory> _byType = {
    UserNotFoundException: (e) =>
        UserNotFoundFailure(message: _displayMessage(e)),
    WrongPasswordException: (e) =>
        WrongPasswordFailure(message: _displayMessage(e)),
    EmailAlreadyRegisteredException: (e) =>
        EmailAlreadyRegisteredFailure(message: _displayMessage(e)),
    PasswordMismatchException: (e) =>
        PasswordMismatchFailure(message: _displayMessage(e)),
    InvalidTokenException: (e) =>
        InvalidTokenFailure(message: _displayMessage(e)),
  };

  static Failure? getByCode(AppException e) {
    final factory = _byCode[e.code];
    return factory != null ? factory(e) : null;
  }

  static Failure? getByType(AppException e) {
    final factory = _byType[e.runtimeType];
    return factory != null ? factory(e) : null;
  }
}
