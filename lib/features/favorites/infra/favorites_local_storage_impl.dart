import 'package:ibiapabaapp/core/cache/base_cache_storage.dart';
import 'package:ibiapabaapp/features/favorites/data/datasources/favorites_local_storage.dart';
import 'package:ibiapabaapp/features/favorites/domain/entities/favorite.dart';
import 'package:ibiapabaapp/features/favorites/infra/models/favorite_model.dart';

class FavoritesLocalStorageImpl extends BaseCacheStorage
    implements FavoritesLocalStorage {
  FavoritesLocalStorageImpl(super.cacheService);

  @override
  String get storeName => 'favorites';

  @override
  Future<void> saveFavoritesByAccount({
    required String accountId,
    required List<Favorite> favorites,
  }) async {
    await saveList(
      key: '$accountId.favorites',
      items: favorites,
      toMap: (i) => FavoriteModel.toMap(i),
    );
  }

  @override
  Future<List<Favorite>> loadFavoritesByAccount({
    required String accountId,
  }) async {
    return await getList(
      key: '$accountId.favorites',
      fromJson: (json) => FavoriteModel.fromJson(json),
    );
  }

  @override
  Future<void> pushFavorite({required Favorite favorite}) async {
    final cachedFavorites = await getList<Favorite>(
      key: '${favorite.accountId}.favorites',
      fromJson: (json) => FavoriteModel.fromJson(json),
    );

    cachedFavorites.add(favorite);
    return saveFavoritesByAccount(
      accountId: favorite.accountId,
      favorites: cachedFavorites,
    );
  }

  @override
  Future<void> popFavorite({required Favorite favorite}) async {
    final cachedFavorites = await getList<Favorite>(
      key: '${favorite.accountId}.favorites',
      fromJson: (json) => FavoriteModel.fromJson(json),
    );

    cachedFavorites.removeWhere((fav) => fav.id == favorite.id);
    return saveFavoritesByAccount(
      accountId: favorite.accountId,
      favorites: cachedFavorites,
    );
  }

  @override
  Future<void> clearFavoritesByAccount({required String accountId}) async {
    await clearKey('$accountId.favorites');
  }
}
