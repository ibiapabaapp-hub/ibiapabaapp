import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ibiapabaapp/core/logger/logger.dart';
import 'package:ibiapabaapp/core/network/dio_logger_interceptor.dart';
import 'package:ibiapabaapp/core/network/dio_provider.dart';
import 'package:ibiapabaapp/core/storage/token_storage_provider.dart';
import 'package:ibiapabaapp/core/storage/token_storage_strategy.dart';
import 'package:logger/logger.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod/riverpod.dart';

class MockTokenStorage extends Mock implements TokenStorageStrategy {}

void main() {
  late MockTokenStorage mockTokenStorage;
  late Logger testLogger;
  late DioLoggerInterceptor testInterceptor;

  setUpAll(() {
    dotenv.load();
  });

  setUp(() {
    mockTokenStorage = MockTokenStorage();
    testLogger = Logger(level: Level.off);
    testInterceptor = DioLoggerInterceptor(testLogger);
  });

  ProviderContainer _createContainer() {
    return ProviderContainer(
      overrides: [
        loggerProvider.overrideWithValue(testLogger),
        dioLoggerInterceptorProvider.overrideWithValue(testInterceptor),
        tokenStorageProvider.overrideWithValue(mockTokenStorage),
      ],
    );
  }

  group('dio provider', () {
    test('should create a Dio instance', () {
      final container = _createContainer();
      addTearDown(container.dispose);

      final dio = container.read(dioProvider);
      expect(dio, isA<Dio>());
    });

    test('should set base URL from dotenv', () {
      final container = _createContainer();
      addTearDown(container.dispose);

      final dio = container.read(dioProvider);
      expect(dio.options.baseUrl, isNotEmpty);
    });

    test('should set connect timeout', () {
      final container = _createContainer();
      addTearDown(container.dispose);

      final dio = container.read(dioProvider);
      expect(dio.options.connectTimeout, const Duration(seconds: 6));
    });

    test('should set default headers', () {
      final container = _createContainer();
      addTearDown(container.dispose);

      final dio = container.read(dioProvider);
      expect(dio.options.headers['Content-Type'], 'application/json');
      expect(dio.options.headers['User-Agent'], 'ibiapabaapp/1.0');
      expect(dio.options.headers['ngrok-skip-browser-warning'], 'true');
    });

    test('should have interceptors configured', () {
      final container = _createContainer();
      addTearDown(container.dispose);

      final dio = container.read(dioProvider);
      expect(dio.interceptors, isNotEmpty);
    });
  });
}
