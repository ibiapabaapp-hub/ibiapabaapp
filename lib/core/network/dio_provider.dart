import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ibiapabaapp/core/logger/logger.dart';
import 'package:ibiapabaapp/core/network/dio_logger_interceptor.dart';
import 'package:ibiapabaapp/core/storage/token_storage_provider.dart';
import 'package:ibiapabaapp/features/auth/presentation/providers/auth_providers.dart';
import 'package:ibiapabaapp/features/auth/presentation/providers/auth_state_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_provider.g.dart';

// Fila global de refresh — evita múltiplos refreshes simultâneos
Future<String?>? _pendingRefresh;
int _globalRetryCount = 0;
const int _maxGlobalRetries = 3;

@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: dotenv.env['API_BASE_URL']!,
      connectTimeout: const Duration(seconds: 6),
      headers: {
        'Content-Type': 'application/json',
        'User-Agent': 'ibiapabaapp/1.0',
        'ngrok-skip-browser-warning': 'true',
      },
    ),
  );

  final logger = ref.watch(loggerProvider);
  final interceptor = ref.watch(dioLoggerInterceptorProvider);
  dio.interceptors.add(interceptor);

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        final isAuthPath = options.path.contains('/auth/');
        if (isAuthPath) return handler.next(options);

        try {
          // Se há um refresh em andamento, aguarda antes de pegar o token
          if (_pendingRefresh != null) {
            await _pendingRefresh;
          }

          if (!ref.mounted) return handler.next(options);

          final storage = ref.read(tokenStorageProvider);
          final token = await storage.getAccessToken();

          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer ${token.trim()}';
          }
        } catch (e, stack) {
          logger.e('Erro no interceptor de token', error: e, stackTrace: stack);
        }

        return handler.next(options);
      },

      onError: (DioException e, handler) async {
        final is401 = e.response?.statusCode == 401;
        // Rotas de auth nunca devem entrar no fluxo de retry
        final isAuthPath = e.requestOptions.path.contains('/auth/');
        final alreadyRetried = e.requestOptions.extra['_retried'] == true;

        if (!is401 || isAuthPath || alreadyRetried || !ref.mounted) {
          return handler.next(e);
        }

        if (_globalRetryCount >= _maxGlobalRetries) {
          logger.w('Limite global de retries atingido. Fazendo logout.');
          _globalRetryCount = 0;
          _pendingRefresh = null;
          if (ref.mounted) {
            await ref.read(authStateProvider.notifier).logout();
          }
          return handler.next(e);
        }

        try {
          // Cria ou reutiliza o refresh em andamento
          _pendingRefresh ??= _doRefresh(ref);

          final newToken = await _pendingRefresh;

          if (newToken == null || !ref.mounted) {
            _pendingRefresh = null;
            await ref.read(authStateProvider.notifier).logout();
            return handler.next(e);
          }

          _globalRetryCount++;

          // Retry com novo token, marcado para não entrar em loop
          final retryOptions = e.requestOptions
            ..headers['Authorization'] = 'Bearer $newToken'
            ..extra['_retried'] = true;

          final response = await dio.fetch(retryOptions);
          _globalRetryCount = 0;
          return handler.resolve(response);
        } catch (err, stack) {
          logger.e('Erro no retry após refresh', error: err, stackTrace: stack);
          _pendingRefresh = null;
          if (ref.mounted) {
            await ref.read(authStateProvider.notifier).logout();
          }
          return handler.next(e);
        }
      },
    ),
  );

  return dio;
}

/// Executa o refresh e retorna o novo accessToken, ou null se falhar.
Future<String?> _doRefresh(Ref ref) async {
  try {
    if (!ref.mounted) return null;

    final result = await ref.read(refreshTokensProvider).call();

    return result.fold(
      (_) {
        _pendingRefresh = null;
        return null;
      },
      (authResult) async {
        if (!ref.mounted) {
          _pendingRefresh = null;
          return null;
        }
        await ref.read(authStateProvider.notifier).initSession(authResult);
        _pendingRefresh = null;
        return authResult.accessToken;
      },
    );
  } catch (e) {
    _pendingRefresh = null;
    return null;
  }
}
