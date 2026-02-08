abstract class Failure {
  final String message;
  final String code;
  const Failure({required this.message, required this.code});
}

class ServerFailure extends Failure {
  const ServerFailure(String message, {required super.code})
    : super(message: message);
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure(String message, {required super.code})
    : super(message: message);
}

class NetworkFailure extends Failure {
  const NetworkFailure(String message, {required super.code})
    : super(message: message);
}

class BadRequestFailure extends Failure {
  const BadRequestFailure(String message, {required super.code})
    : super(message: message);
}

class ForbiddenFailure extends Failure {
  const ForbiddenFailure(String message, {required super.code})
    : super(message: message);
}

class NotFoundFailure extends Failure {
  const NotFoundFailure(String message, {required super.code})
    : super(message: message);
}
