import 'package:ibiapabaapp/core/cache/cache_database_service.dart';
import 'package:ibiapabaapp/core/logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cache_database_provider.g.dart';

@Riverpod(keepAlive: true)
CacheDatabaseService cacheDatabaseService(Ref ref) {
  final logger = ref.watch(loggerProvider);
  return CacheDatabaseService(logger: logger);
}

@riverpod
Future<CacheDatabaseService> initializedCacheService(Ref ref) async {
  final service = ref.watch(cacheDatabaseServiceProvider);
  await service.init();
  return service;
}

@riverpod
Future<void> clearUnnecessaryCache(Ref ref) async {
  final service = ref.watch(cacheDatabaseServiceProvider);

  final nonEssentialStores = [
    'location',
    'search',
    'categories_cache',
    'cities_store',
  ];

  for (final storeName in nonEssentialStores) {
    await service.clear(storeName: storeName);
  }
}
