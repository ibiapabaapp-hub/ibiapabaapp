import 'package:ibiapabaapp/core/cache/cache_database_provider.dart';
import 'package:ibiapabaapp/core/logger/logger.dart';
import 'package:ibiapabaapp/core/network/dio_provider.dart';
import 'package:ibiapabaapp/features/accounts/data/datasources/accounts_local_storage.dart';
import 'package:ibiapabaapp/features/accounts/data/repositories/accounts_repository_impl.dart';
import 'package:ibiapabaapp/features/accounts/domain/repositories/accounts_repository.dart';
import 'package:ibiapabaapp/features/accounts/infra/accounts_local_storage_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'accounts_providers.g.dart';

// ============ DATA ============
@riverpod
AccountsLocalStorage accountsLocalStorage(Ref ref) {
  final cacheService = ref.watch(cacheDatabaseServiceProvider);
  return AccountsLocalStorageImpl(cacheService);
}

@riverpod
AccountsRepository accountsRepository(Ref ref) {
  final logger = ref.watch(loggerProvider);
  final dio = ref.watch(dioProvider);
  final local = ref.watch(accountsLocalStorageProvider);
  return AccountsRepositoryImpl(
    dio: dio,
    localStorage: local,
    logger: logger,
  );
}
