import 'package:dartz/dartz.dart';
import 'package:ibiapabaapp/core/errors/failures/failures.dart';
import 'package:ibiapabaapp/core/usecases/usecase.dart';
import 'package:ibiapabaapp/features/favorites/domain/entities/favorite.dart';
import 'package:ibiapabaapp/features/favorites/domain/repositories/favorites_repository.dart';

class PushFavorite implements Usecase<Favorite, PushFavoriteParams> {
  final FavoritesRepository repository;
  PushFavorite(this.repository);

  @override
  Future<Either<AppFailure, Favorite>> call(PushFavoriteParams params) {
    return repository.pushFavorite(favorite: params.favorite);
  }
}

class PushFavoriteParams {
  final Favorite favorite;
  PushFavoriteParams({required this.favorite});
}
