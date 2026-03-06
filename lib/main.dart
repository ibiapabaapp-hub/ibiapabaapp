import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ibiapabaapp/app/app.dart';
import 'package:ibiapabaapp/core/cache/cache_database_service.dart';
import 'package:ibiapabaapp/core/logger/logger.dart';
import 'package:ibiapabaapp/features/auth/presentation/providers/session_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  await CacheDatabaseService.init();
  final container = ProviderContainer();

  try {
    await container.read(sessionProvider.notifier).restoreSession();
  } catch (e) {
    logger.d('Erro ao restaurar sessão: $e');
  }

  runApp(UncontrolledProviderScope(container: container, child: const App()));
}
