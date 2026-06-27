import 'package:ibiapabaapp/core/errors/exceptions/exceptions.dart';

sealed class LocationException extends AppException {
  const LocationException(super.message, {super.code = 'LOCATION_ERROR'});
}

class LocationPermissionDeniedException extends LocationException {
  const LocationPermissionDeniedException()
    : super(
        'Permissão de localização negada.',
        code: 'LOCATION_PERMISSION_DENIED',
      );
}

class LocationPermissionPermanentlyDeniedException extends LocationException {
  const LocationPermissionPermanentlyDeniedException()
    : super(
        'Permissão de localização negada permanentemente. Acesse as configurações do app.',
        code: 'LOCATION_PERMISSION_PERMANENTLY_DENIED',
      );
}

class LocationDisabledException extends LocationException {
  const LocationDisabledException()
    : super(
        'Serviço de localização desativado no dispositivo.',
        code: 'LOCATION_DISABLED',
      );
}

class LocationTimeoutException extends LocationException {
  const LocationTimeoutException()
    : super('Tempo esgotado ao obter a localização.', code: 'LOCATION_TIMEOUT');
}

class LocationUnknownException extends LocationException {
  const LocationUnknownException(
    super.message, {
    super.code = 'LOCATION_UNKNOWN',
  });
}
