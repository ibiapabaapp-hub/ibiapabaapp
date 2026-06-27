abstract class AppFailure {
  final String message;
  final String code;
  const AppFailure({required this.message, required this.code});
}

class InternalFailure extends AppFailure {
  const InternalFailure(String message)
    : super(message: message, code: 'internal_error');
}

class ServerFailure extends AppFailure {
  const ServerFailure(String message)
    : super(message: message, code: 'server_error');
}

class UnauthorizedFailure extends AppFailure {
  const UnauthorizedFailure(String message, {required super.code})
    : super(message: message);
}

class NetworkFailure extends AppFailure {
  const NetworkFailure(String message, {required super.code})
    : super(message: message);
}

class BadRequestFailure extends AppFailure {
  const BadRequestFailure(String message, {required super.code})
    : super(message: message);
}

class ForbiddenFailure extends AppFailure {
  const ForbiddenFailure(String message, {required super.code})
    : super(message: message);
}

class NotFoundFailure extends AppFailure {
  const NotFoundFailure(String message, {required super.code})
    : super(message: message);
}

class LocationPermissionDeniedFailure extends AppFailure {
  const LocationPermissionDeniedFailure()
    : super(
        message: 'Permissão de localização negada.',
        code: 'location_permission_denied',
      );
}

class LocationPermissionPermanentlyDeniedFailure extends AppFailure {
  const LocationPermissionPermanentlyDeniedFailure()
    : super(
        message: 'Permissão negada permanentemente. Acesse as configurações.',
        code: 'location_permission_denied_permanently',
      );
}

class LocationDisabledFailure extends AppFailure {
  const LocationDisabledFailure()
    : super(
        message: 'Serviço de localização desativado.',
        code: 'location_service_disabled',
      );
}

class LocationTimeoutFailure extends AppFailure {
  const LocationTimeoutFailure()
    : super(
        message: 'Tempo esgotado ao obter a localização.',
        code: 'location_service_timeout',
      );
}

class LocationUnknownFailure extends AppFailure {
  const LocationUnknownFailure(String message)
    : super(message: message, code: 'location_service_unknown_error');
}
