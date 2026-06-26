import 'package:ibiapabaapp/core/cache/cache_database_provider.dart';
import 'package:ibiapabaapp/core/logger/logger.dart';
import 'package:ibiapabaapp/core/network/dio_provider.dart';
import 'package:ibiapabaapp/features/favorites/data/datasources/favorites_local_storage.dart';
import 'package:ibiapabaapp/features/favorites/data/datasources/favorites_remote_datasource.dart';
import 'package:ibiapabaapp/features/favorites/data/repositories/favorites_repository_impl.dart';
import 'package:ibiapabaapp/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:ibiapabaapp/features/favorites/infra/favorites_local_storage_impl.dart';
import 'package:ibiapabaapp/features/favorites/infra/favorites_remote_datasource_impl.dart';
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
