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
  Future<void> saveFavoritesByProfile({
    required String profileId,
    required List<Favorite> favorites,
  }) async {
    await saveList(
      key: '$profileId.favorites',
      items: favorites,
      toMap: (i) => FavoriteModel.toMap(i),
    );
  }

  @override
  Future<List<Favorite>> loadFavoritesByProfile({
    required String profileId,
  }) async {
    return await getList(
      key: '$profileId.favorites',
      fromJson: (json) => FavoriteModel.fromJson(json),
    );
  }

  @override
  Future<void> pushFavorite({required Favorite favorite}) async {
    final cachedFavorites = await getList<Favorite>(
      key: '${favorite.profileId}.favorites',
      fromJson: (json) => FavoriteModel.fromJson(json),
    );

    cachedFavorites.add(favorite);
    return saveFavoritesByProfile(
      profileId: favorite.profileId,
      favorites: cachedFavorites,
    );
  }

  @override
  Future<void> popFavorite({required Favorite favorite}) async {
    final cachedFavorites = await getList<Favorite>(
      key: '${favorite.profileId}.favorites',
      fromJson: (json) => FavoriteModel.fromJson(json),
    );

    cachedFavorites.removeWhere((fav) => fav.id == favorite.id);
    return saveFavoritesByProfile(
      profileId: favorite.profileId,
      favorites: cachedFavorites,
    );
  }

  @override
  Future<void> clearFavoritesByProfile({required String profileId}) async {
    await clearKey('$profileId.favorites');
  }
}
