import 'package:dartz/dartz.dart';
import 'package:ibiapabaapp/core/errors/failures/failures.dart';
import 'package:ibiapabaapp/features/favorites/domain/entities/favorite.dart';

abstract class FavoritesRepository {
  Future<Either<AppFailure, List<Favorite>>> getAllFavoritesByProfile({
    required String profileId,
  });
  Future<Either<AppFailure, Favorite>> pushFavorite({
    required Favorite favorite,
  });
  Future<Either<AppFailure, Favorite>> popFavorite({
    required Favorite favorite,
  });
}
