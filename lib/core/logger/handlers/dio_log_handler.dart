import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ibivibe/core/logger/log_tags.dart';
import 'package:ibivibe/core/network/network_logtags.dart';
import 'package:logger/logger.dart';

mixin DioLogHandler {
  Logger get logger;

  static const JsonEncoder _encoder = JsonEncoder.withIndent('  ');

  String _prettyPrint(dynamic data) {
    if (data == null) return 'null';
    try {
      if (data is Map || data is List) return _encoder.convert(data);
      if (data is String &&
          (data.trim().startsWith('{') || data.trim().startsWith('['))) {
        return _encoder.convert(json.decode(data));
      }
    } catch (_) {}
    return data.toString();
  }

  void logRequest(RequestOptions options) {
    final tag =
        '${LogLayer.network.tag}${LogLib.dio.tag}${NetworkAction.request.tag}';
    logger.d(
      '$tag ➡️ ${options.method} ${options.uri}\n'
      'Headers: ${_prettyPrint(options.headers)}\n'
      'Body: ${_prettyPrint(options.data)}',
    );
  }

  void logResponse(Response response) {
    final tag =
        '${LogLayer.network.tag}${LogLib.dio.tag}${NetworkAction.response.tag}';
    logger.i(
      '$tag ✅ ${response.statusCode} ${response.requestOptions.uri}\n'
      'Data: ${_prettyPrint(response.data)}',
    );
  }

  void logError(DioException err) {
    final tag =
        '${LogLayer.network.tag}${LogLib.dio.tag}${LogStatus.error.tag}';
    logger.e(
      '$tag ❌ ${err.requestOptions.method} ${err.requestOptions.uri}\n'
      'Status: ${err.response?.statusCode}\n'
      'Message: ${err.message}',
      error: err.error,
      stackTrace: err.stackTrace,
    );
  }
}
