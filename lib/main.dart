import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ibiapabaapp/app/app.dart';
import 'package:ibiapabaapp/core/cache/cache_database_provider.dart';
import 'package:ibiapabaapp/core/logger/logger.dart';
import 'package:ibiapabaapp/core/session/app_session_notifier_provider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  final container = ProviderContainer();

  // Warm-up
  try {
    await Future.wait([
      dotenv.load(fileName: ".env"),
      container.read(cacheDatabaseProvider.future),
    ]);
    await container.read(appSessionProvider.notifier).restore();
  } catch (e, stack) {
    final logger = container.read(loggerProvider);
    logger.e(
      'Erro fatal ao restaurar sessão na main',
      error: e,
      stackTrace: stack,
    );
  } finally {
    FlutterNativeSplash.remove();
  }

  runApp(UncontrolledProviderScope(container: container, child: const App()));
}
