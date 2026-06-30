import 'package:dio/dio.dart';
import 'package:ibivibe/core/errors/exceptions/exceptions.dart';
import 'package:ibivibe/features/auth/auth_exceptions.dart';

// extrai [code] e [message] do body da resposta.
// aceita: { code }, { error }, { message }, { errors: [string] }.
class _ResponsePayload {
  const _ResponsePayload({this.code, required this.message});

  final String? code;
  final String message;

  static _ResponsePayload from(dynamic data) {
    String message = 'Erro inesperado';
    String? code;

    if (data is Map<String, dynamic>) {
      message = _extractMessage(data, message);
      code =
          data['code']?.toString() ??
          data['error']?.toString() ??
          data['errorCode']?.toString();
    }

    return _ResponsePayload(code: code, message: message);
  }

  static String _extractMessage(Map<String, dynamic> data, String fallback) {
    final m = data['message'];
    if (m is String) return m;
    if (m != null) return m.toString();
    final errors = data['errors'];
    if (errors is List && errors.isNotEmpty) {
      final first = errors.first;
      return first is String ? first : first.toString();
    }
    return fallback;
  }
}

// mapeia apenas por [code] retornado pelo backend, sem inferência por mensagem.
// exige code + message: se o backend não enviar code, usa [http_<status>].
class DioExceptionToAppExceptionMapper {
  static String _code(int? status, String? backendCode) {
    if (backendCode != null && backendCode.trim().isNotEmpty) {
      return backendCode.trim();
    }
    final s = status ?? 0;
    return s > 0 ? 'http_$s' : 'unknown';
  }

  static AppException map(DioException e) {
    if (e.response == null) {
      return _DioExceptionRegistry.noResponse;
    }

    final payload = _ResponsePayload.from(e.response?.data);
    final statusCode = e.response?.statusCode;
    final backendCode = payload.code?.trim();
    final code = _code(statusCode, backendCode);
    final message = payload.message.trim().isNotEmpty
        ? payload.message
        : 'Erro inesperado';

    if (backendCode != null && backendCode.isNotEmpty) {
      final exception = _DioExceptionRegistry.getByBackendCode(backendCode);
      if (exception != null) return exception(message);
    }

    return _DioExceptionRegistry.getByStatusCode(statusCode)(message, code);
  }
}

typedef ExceptionFactoryWithMessage = AppException Function(String message);
typedef ExceptionFactoryWithCode =
    AppException Function(String message, String code);

class _DioExceptionRegistry {
  static const AppException noResponse = NetworkException(
    'Erro de conexão. Verifique sua internet.',
    code: 'network_error',
  );

  static final Map<String, ExceptionFactoryWithMessage> _byBackendCode = {
    'user_not_found': (m) => UserNotFoundException(m),
    'wrong_password': (m) => WrongPasswordException(m),
    'invalid_credentials': (m) => WrongPasswordException(m),
    'email_already_registered': (m) => EmailAlreadyRegisteredException(m),
    'password_mismatch': (m) => PasswordMismatchException(m),
    'invalid_token': (m) => InvalidTokenException(m),
  };

  static final Map<int?, ExceptionFactoryWithCode> _byStatusCode = {
    400: (m, c) => BadRequestException(m, code: c),
    401: (m, c) => UnauthorizedException(m, code: c),
    403: (m, c) => ForbiddenException(m, code: c),
    404: (m, c) => NotFoundException(m, code: c),
    500: (m, c) => ServerException(m, code: c),
  };

  static ExceptionFactoryWithCode get _default =>
      (m, c) => ServerException(m, code: c);

  static ExceptionFactoryWithMessage? getByBackendCode(String code) =>
      _byBackendCode[code];

  static ExceptionFactoryWithCode getByStatusCode(int? statusCode) =>
      _byStatusCode[statusCode] ?? _default;
}
