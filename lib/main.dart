import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ibivibe/app/app.dart';
import 'package:ibivibe/core/cache/cache_database_provider.dart';
import 'package:ibivibe/core/logger/logger.dart';
import 'package:ibivibe/core/session/app_session_notifier_provider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // container temporário para o warm-up
  final container = ProviderContainer();

  try {
    await dotenv.load(fileName: ".env");
    await container.read(initializedCacheServiceProvider.future);
    await container.read(appSessionProvider.notifier).restore();

    runApp(UncontrolledProviderScope(container: container, child: const App()));
  } catch (e, stack) {
    container
        .read(loggerProvider)
        .e('Erro fatal na main', error: e, stackTrace: stack);
    runApp(UncontrolledProviderScope(container: container, child: const App()));
  } finally {
    FlutterNativeSplash.remove();
  }
}
