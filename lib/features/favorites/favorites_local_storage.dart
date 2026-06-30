import 'package:ibivibe/features/favorites/models/favorite.dart';

abstract class FavoritesLocalStorage {
  Future<void> saveFavoritesByAccount({
    required String accountId,
    required List<Favorite> favorites,
  });
  Future<List<Favorite>> loadFavoritesByAccount({required String accountId});
  Future<void> clearFavoritesByAccount({required String accountId});
  Future<void> pushFavorite({required Favorite favorite});
  Future<void> popFavorite({required Favorite favorite});
}
