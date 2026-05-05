import 'package:ibiapabaapp/features/favorites/domain/entities/favorite.dart';

abstract class FavoritesLocalStorage {
  Future<void> saveFavoritesByProfile({
    required String profileId,
    required List<Favorite> favorites,
  });
  Future<List<Favorite>> loadFavoritesByProfile({required String profileId});
  Future<void> clearFavoritesByProfile({required String profileId});
  Future<void> pushFavorite({required Favorite favorite});
  Future<void> popFavorite({required Favorite favorite});
}
