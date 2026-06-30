import 'package:ibivibe/core/cache/cache_database_provider.dart';
import 'package:ibivibe/core/logger/logger.dart';
import 'package:ibivibe/core/network/dio_provider.dart';
import 'package:ibivibe/features/accounts/accounts_local_storage.dart';
import 'package:ibivibe/features/accounts/accounts_repository_impl.dart';
import 'package:ibivibe/features/accounts/accounts_repository.dart';
import 'package:ibivibe/features/accounts/accounts_local_storage_impl.dart';
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
