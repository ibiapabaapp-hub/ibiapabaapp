import 'package:dartz/dartz.dart';
import 'package:ibiapabaapp/core/errors/failures/failures.dart';
import 'package:ibiapabaapp/core/usecases/usecase.dart';
import 'package:ibiapabaapp/features/favorites/domain/entities/favorite.dart';
import 'package:ibiapabaapp/features/favorites/domain/repositories/favorites_repository.dart';

class PopFavorite implements Usecase<Favorite, PopFavoriteParams> {
  final FavoritesRepository repository;
  PopFavorite(this.repository);

  @override
  Future<Either<AppFailure, Favorite>> call(PopFavoriteParams params) {
    return repository.popFavorite(favorite: params.favorite);
  }
}

class PopFavoriteParams {
  final Favorite favorite;
  PopFavoriteParams({required this.favorite});
}
