import 'package:ibiapabaapp/core/cache/base_cache_storage.dart';
import 'package:ibiapabaapp/features/search/data/datasources/search_local_storage.dart';

class SearchLocalStorageImpl extends BaseCacheStorage
    implements SearchLocalStorage {
  SearchLocalStorageImpl(super.cacheService);

  @override
  String get storeName => 'search';

  @override
  Future<void> saveRecentSearches(List<String> searches) async {
    await saveList(
      key: 'recent_searches',
      items: searches,
      toMap: (i) => {'value': i},
    );
  }

  @override
  Future<List<String>> getRecentSearches() async {
    return getList(key: 'recent_searches', fromJson: (json) => json['value']);
  }
}
