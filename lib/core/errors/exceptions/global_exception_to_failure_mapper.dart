import 'exceptions.dart';
import '../failures/failures.dart';

typedef ExceptionToFailureFactory = AppFailure Function(AppException e);

class GlobalExceptionToFailureMapper {
  static AppFailure map(Object error) {
    try {
      if (error is AppException) {
        final factory = _GlobalExceptionFailureRegistry.getByType(error);
        return factory(error);
      }

      return _GlobalExceptionFailureRegistry.fallback;
    } catch (e) {
      return _GlobalExceptionFailureRegistry.fallback;
    }
  }
}

class _GlobalExceptionFailureRegistry {
  static const Map<Type, String> _userMessageByType = {
    ServerException: 'Algo deu errado no servidor. Tente novamente mais tarde.',
    BadRequestException:
        'Dados inválidos. Verifique as informações e tente novamente.',
    ForbiddenException: 'Você não tem permissão para acessar este recurso.',
    NotFoundException: 'Recurso não encontrado.',
    UnauthorizedException: 'Sessão expirada. Faça login novamente.',
    NetworkException: 'Sem conexão. Verifique sua internet e tente novamente.',
  };

  static const AppFailure fallback = ServerFailure(
    'Ocorreu um erro inesperado. Tente novamente.',
  );

  static String _displayMessage(AppException e) {
    final message = _userMessageByType[e.runtimeType];
    if (message != null) return message;
    return e.message.isNotEmpty ? e.message : 'Erro desconhecido';
  }

  static final Map<Type, ExceptionToFailureFactory> _byType = {
    ServerException: (e) => ServerFailure(_displayMessage(e)),
    BadRequestException: (e) =>
        BadRequestFailure(_displayMessage(e), code: e.code),
    ForbiddenException: (e) =>
        ForbiddenFailure(_displayMessage(e), code: e.code),
    NotFoundException: (e) => NotFoundFailure(_displayMessage(e), code: e.code),
    UnauthorizedException: (e) =>
        UnauthorizedFailure(_displayMessage(e), code: e.code),
    NetworkException: (e) => NetworkFailure(_displayMessage(e), code: e.code),
  };

  static ExceptionToFailureFactory getByType(AppException e) {
    return _byType[e.runtimeType] ??
        (err) => ServerFailure(_displayMessage(err));
  }
}
