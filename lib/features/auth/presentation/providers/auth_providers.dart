import 'package:ibiapabaapp/core/logger/logger.dart';
import 'package:ibiapabaapp/core/network/dio_provider.dart';
import 'package:ibiapabaapp/core/storage/token_storage_provider.dart';
import 'package:ibiapabaapp/features/auth/domain/repositories/auth_repository.dart';
import 'package:ibiapabaapp/features/auth/presentation/controllers/login_controller.dart';
import 'package:ibiapabaapp/features/auth/presentation/providers/auth_state_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ibiapabaapp/features/auth/data/repositories/auth_repository_impl.dart';

part 'auth_providers.g.dart';

// DATA
@riverpod
AuthRepository authRepository(Ref ref) {
  final dio = ref.watch(dioProvider);
  final tokenStorage = ref.watch(tokenStorageProvider);
  return AuthRepositoryImpl(dio, tokenStorage);
}

// CONTROLLERS
@riverpod
LoginController loginController(Ref ref) {
  final logger = ref.watch(loggerProvider);
  final repository = ref.watch(authRepositoryProvider);
  final authState = ref.watch(authStateProvider.notifier);

  return LoginController(
    repository: repository,
    authState: authState,
    logger: logger,
  );
}
