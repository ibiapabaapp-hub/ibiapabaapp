import 'package:ibivibe/core/cache/cache_database_provider.dart';
import 'package:ibivibe/core/logger/logger.dart';
import 'package:ibivibe/core/network/dio_provider.dart';
import 'package:ibivibe/features/favorites/favorites_local_storage.dart';
import 'package:ibivibe/features/favorites/favorites_remote_datasource.dart';
import 'package:ibivibe/features/favorites/favorites_repository_impl.dart';
import 'package:ibivibe/features/favorites/favorites_repository.dart';
import 'package:ibivibe/features/favorites/favorites_local_storage_impl.dart';
import 'package:ibivibe/features/favorites/favorites_remote_datasource_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'favorites_providers.g.dart';

@riverpod
FavoritesRemoteDatasource favoritesRemoteDatasource(Ref ref) {
  final dio = ref.watch(dioProvider);
  return FavoritesRemoteDatasourceImpl(dio);
}

@riverpod
FavoritesLocalStorage favoritesLocalStorage(Ref ref) {
  final cacheService = ref.watch(cacheDatabaseServiceProvider);
  return FavoritesLocalStorageImpl(cacheService);
}

@riverpod
FavoritesRepository favoritesRepository(Ref ref) {
  final logger = ref.watch(loggerProvider);
  final remote = ref.watch(favoritesRemoteDatasourceProvider);
  final local = ref.watch(favoritesLocalStorageProvider);
  return FavoritesRepositoryImpl(
    remoteDatasource: remote,
    localStorage: local,
    logger: logger,
  );
}
