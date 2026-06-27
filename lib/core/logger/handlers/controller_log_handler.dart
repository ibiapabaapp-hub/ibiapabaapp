import 'package:ibiapabaapp/core/logger/log_tags.dart';
import 'package:logger/logger.dart';

mixin ControllerLogHandler {
  Logger get logger;
  LogFeature get feature;
  LogLayer get defaultLayer => LogLayer.controller;

  void logControllerError({
    required LogTag action,
    required dynamic failure,
    StackTrace? stackTrace,
  }) {
    final String fullTag =
        '${defaultLayer.tag}${feature.tag}${action.tag}${LogStatus.error.tag}';

    final code = _extractErrorCode(failure);
    final message = _extractErrorMessage(failure);

    logger.w(
      fullTag,
      error: {
        'failure': failure.runtimeType.toString(),
        'code': code,
        'message': message,
      },
      stackTrace: stackTrace,
    );
  }

  String _extractErrorCode(dynamic error) {
    try {
      return error.code?.toString() ?? 'unknown';
    } catch (_) {
      return error.runtimeType.toString();
    }
  }

  String _extractErrorMessage(dynamic error) {
    try {
      return error.message?.toString() ?? 'unknown';
    } catch (_) {
      return error.toString();
    }
  }

  void logControllerSuccess({required LogTag action}) {
    final String fullTag =
        '${defaultLayer.tag}${feature.tag}${action.tag}${LogStatus.success.tag}';
    logger.i(fullTag);
  }
}
