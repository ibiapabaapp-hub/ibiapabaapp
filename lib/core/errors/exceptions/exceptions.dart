abstract class AppException implements Exception {
  final String message;
  final String code;

  const AppException(this.message, {required this.code});

  @override
  String toString() => '[$code] $message';
}

class ServerException extends AppException {
  const ServerException(super.message, {required super.code});
}

class BadRequestException extends AppException {
  const BadRequestException(super.message, {required super.code});
}

class ForbiddenException extends AppException {
  const ForbiddenException(super.message, {required super.code});
}

class NotFoundException extends AppException {
  const NotFoundException(super.message, {required super.code});
}

class UnauthorizedException extends AppException {
  const UnauthorizedException(super.message, {required super.code});
}

class NetworkException extends AppException {
  const NetworkException(super.message, {required super.code});
}
