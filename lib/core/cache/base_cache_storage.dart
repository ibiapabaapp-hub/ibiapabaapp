import 'package:ibivibe/core/cache/cache_database_service.dart';

abstract class BaseCacheStorage {
  final CacheDatabaseService cacheService;
  String get storeName;

  BaseCacheStorage(this.cacheService);

  Future<void> saveObject<T>({
    required String key,
    required T item,
    required Map<String, dynamic> Function(T) toMap,
  }) async {
    await cacheService.saveObject<T>(
      storeName: storeName,
      key: key,
      item: item,
      toMap: toMap,
    );
  }

  Future<T?> getObject<T>({
    required String key,
    required T Function(Map<String, dynamic>) fromJson,
    Duration? maxAge,
  }) async {
    return cacheService.getObject<T>(
      storeName: storeName,
      key: key,
      fromJson: fromJson,
      maxAge: maxAge,
    );
  }

  Future<void> saveList<T>({
    required List<T> items,
    required Map<String, dynamic> Function(T) toMap,
    String? key,
  }) async {
    await cacheService.saveList<T>(
      storeName: storeName,
      items: items,
      toMap: toMap,
      key: key,
    );
  }

  Future<List<T>> getList<T>({
    required T Function(Map<String, dynamic>) fromJson,
    String? key,
    Duration? maxAge,
  }) async {
    return cacheService.getList<T>(
      storeName: storeName,
      fromJson: fromJson,
      key: key,
      maxAge: maxAge,
    );
  }

  Future<void> clearKey(String key) async {
    await cacheService.clearKey(storeName: storeName, key: key);
  }

  Future<void> clear() async => await cacheService.clear(storeName: storeName);
}
