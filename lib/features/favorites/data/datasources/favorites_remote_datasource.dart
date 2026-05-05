import 'package:ibiapabaapp/features/favorites/domain/entities/favorite.dart';

abstract class FavoritesRemoteDatasource {
  Future<List<Favorite>> getAllFavoritesByProfile({required String profileId});
  Future<Favorite> pushFavorite({required Favorite favorite});
  Future<Favorite> popFavorite({required Favorite favorite});
}
