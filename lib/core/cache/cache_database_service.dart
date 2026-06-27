import 'package:logger/logger.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast_io.dart';

class CacheDatabaseService {
  final Logger _logger;
  late final Database _db;

  CacheDatabaseService({required Logger logger}) : _logger = logger;

  Future<Database> init() async {
    final appDir = await getApplicationCacheDirectory();
    final dbPath = join(appDir.path, 'ibivibe_cache.db');

    _db = await databaseFactoryIo.openDatabase(dbPath);
    _logger.i('📦 [Sembast] Banco inicializado em: $dbPath');
    return _db;
  }

  Future<void> saveObject<T>({
    required String storeName,
    required String key,
    required T item,
    required Map<String, dynamic> Function(T) toMap,
  }) async {
    final store = stringMapStoreFactory.store(storeName);
    await store.record(key).put(_db, {
      'last_update': DateTime.now().toIso8601String(),
      ...toMap(item),
    });
    _logger.d('💾 [Sembast] Objeto "$key" salvo em "$storeName".');
  }

  Future<T?> getObject<T>({
    required String storeName,
    required String key,
    required T Function(Map<String, dynamic>) fromJson,
    Duration? maxAge,
  }) async {
    final store = stringMapStoreFactory.store(storeName);
    final snapshot = await store.record(key).get(_db);

    if (snapshot == null) return null;

    if (maxAge != null) {
      final lastUpdate = DateTime.tryParse(
        snapshot['last_update'] as String? ?? '',
      );
      if (lastUpdate == null ||
          DateTime.now().difference(lastUpdate) > maxAge) {
        return null;
      }
    }

    return fromJson(snapshot);
  }

  Future<void> saveList<T>({
    required String storeName,
    required List<T> items,
    required Map<String, dynamic> Function(T) toMap,
    String? key,
  }) async {
    final store = stringMapStoreFactory.store(storeName);
    final timestamp = DateTime.now().toIso8601String();
    final recordKey = key ?? 'all_items';

    await store.record(recordKey).put(_db, {
      'last_update': timestamp,
      'data': items.map((i) => toMap(i)).toList(),
    });

    _logger.d(
      '💾 [Sembast] ${items.length} itens salvos em "$storeName" ($recordKey).',
    );
  }

  Future<List<T>> getList<T>({
    required String storeName,
    required T Function(Map<String, dynamic>) fromJson,
    String? key,
    Duration? maxAge,
  }) async {
    final store = stringMapStoreFactory.store(storeName);
    final recordKey = key ?? 'all_items';
    final snapshot = await store.record(recordKey).get(_db);

    if (snapshot == null) return [];

    // Verificação de expiração (TTL)
    if (maxAge != null) {
      final lastUpdate = DateTime.tryParse(
        snapshot['last_update'] as String? ?? '',
      );
      if (lastUpdate == null ||
          DateTime.now().difference(lastUpdate) > maxAge) {
        _logger.w('⏰ [Sembast] Cache de "$storeName" expirado.');
        return [];
      }
    }

    final list = snapshot['data'] as List<dynamic>? ?? [];
    return list.map((item) => fromJson(item as Map<String, dynamic>)).toList();
  }

  Future<void> clearKey({
    required String storeName,
    required String key,
  }) async {
    await stringMapStoreFactory.store(storeName).record(key).delete(_db);
    _logger.i('🧹 [Sembast] Key "$key" limpa em "$storeName".');
  }

  Future<void> clear({String? storeName}) async {
    if (storeName != null) {
      await stringMapStoreFactory.store(storeName).delete(_db);
      _logger.i('🧹 [Sembast] Store "$storeName" limpa.');
    } else {
      await _db.transaction((txn) async {
        await stringMapStoreFactory.store('categories_cache').delete(txn);
        await stringMapStoreFactory.store('cities_store').delete(txn);
      });
      _logger.i('🧹 [Sembast] Cache total limpo.');
    }
  }
}
