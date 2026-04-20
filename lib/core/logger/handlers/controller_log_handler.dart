import 'package:ibiapabaapp/core/logger/log_tags.dart';
import 'package:logger/logger.dart';

mixin ControllerLogHandler {
  Logger get logger;
  LogFeature get feature;
  LogLayer get defaultLayer => LogLayer.controller;

  void logControllerError({
    required LogTag action,
    required dynamic failure,
  }) {
    final String fullTag =
        '${defaultLayer.tag}${feature.tag}${action.tag}${LogStatus.error.tag}';

    logger.w(
      fullTag,
      error: {
        'failure': failure.runtimeType.toString(),
        'code': failure.code,
        'message': failure.message,
      },
    );
  }

  void logControllerSuccess({required LogTag action}) {
    final String fullTag =
        '${defaultLayer.tag}${feature.tag}${action.tag}${LogStatus.success.tag}';
    logger.i(fullTag);
  }
}
