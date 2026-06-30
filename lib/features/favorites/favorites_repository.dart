import 'package:ibivibe/features/favorites/models/favorite.dart';

abstract class FavoritesRepository {
  Future<List<Favorite>> getAllFavoritesByAccount({
    required String accountId,
  });
  Future<Favorite> pushFavorite({
    required Favorite favorite,
  });
  Future<Favorite> popFavorite({
    required Favorite favorite,
  });
}
