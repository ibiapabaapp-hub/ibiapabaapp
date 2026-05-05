import 'package:dartz/dartz.dart';
import 'package:ibiapabaapp/core/errors/failures/failures.dart';
import 'package:ibiapabaapp/core/usecases/usecase.dart';
import 'package:ibiapabaapp/features/favorites/domain/entities/favorite.dart';
import 'package:ibiapabaapp/features/favorites/domain/repositories/favorites_repository.dart';

class GetAllFavoritesByProfile
    implements Usecase<List<Favorite>, GetAllFavoritesByProfileParams> {
  final FavoritesRepository repository;
  GetAllFavoritesByProfile(this.repository);

  @override
  Future<Either<AppFailure, List<Favorite>>> call(
    GetAllFavoritesByProfileParams params,
  ) {
    return repository.getAllFavoritesByProfile(profileId: params.profileId);
  }
}

class GetAllFavoritesByProfileParams {
  final String profileId;
  GetAllFavoritesByProfileParams({required this.profileId});
}
