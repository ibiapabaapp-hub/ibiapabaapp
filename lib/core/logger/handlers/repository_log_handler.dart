import 'package:ibivibe/core/errors/exceptions/global_exception_to_failure_mapper.dart';
import 'package:ibivibe/core/errors/failures/failures.dart';
import 'package:ibivibe/core/logger/log_tags.dart';
import 'package:logger/logger.dart';

mixin RepositoryLogHandler {
  Logger get logger;
  LogFeature get feature;

  AppFailure Function(Object) get featureMapper =>
      GlobalExceptionToFailureMapper.map;

  AppFailure handleRepositoryError({
    required dynamic exception,
    required StackTrace stackTrace,
    required LogTag action,
  }) {
    final String fullTag =
        '${LogLayer.repository.tag}${feature.tag}${action.tag}';

    logger.e(
      fullTag,
      error: {
        'exception': exception.runtimeType.toString(),
        'message': exception.toString(),
      },
      stackTrace: stackTrace,
    );

    return featureMapper(exception);
  }
}
