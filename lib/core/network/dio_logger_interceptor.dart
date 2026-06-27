import 'package:dio/dio.dart';
import 'package:ibivibe/core/logger/handlers/dio_log_handler.dart';
import 'package:ibivibe/core/logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:logger/logger.dart';

part 'dio_logger_interceptor.g.dart';

class DioLoggerInterceptor extends Interceptor with DioLogHandler {
  @override
  final Logger logger;
  DioLoggerInterceptor(this.logger);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logRequest(options);
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logResponse(response);
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    logError(err);
    return handler.next(err);
  }
}

@Riverpod(keepAlive: true)
DioLoggerInterceptor dioLoggerInterceptor(Ref ref) {
  final logger = ref.watch(loggerProvider);
  return DioLoggerInterceptor(logger);
}
