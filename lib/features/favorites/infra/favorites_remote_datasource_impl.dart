import 'package:dio/dio.dart';
import 'package:ibiapabaapp/features/favorites/data/datasources/favorites_remote_datasource.dart';
import 'package:ibiapabaapp/features/favorites/domain/entities/favorite.dart';
import 'package:ibiapabaapp/features/favorites/infra/models/favorite_model.dart';

class FavoritesRemoteDatasourceImpl implements FavoritesRemoteDatasource {
  final Dio dio;

  FavoritesRemoteDatasourceImpl(this.dio);

  @override
  Future<List<Favorite>> getAllFavoritesByProfile({
    required String profileId,
  }) async {
    final response = await dio.get(
      '/favorites',
      queryParameters: {'profile_id': profileId},
    );
    return FavoriteModel.fromJsonList(response.data);
  }

  @override
  Future<Favorite> pushFavorite({required Favorite favorite}) async {
    final response = await dio.post(
      '/favorites',
      data: FavoriteModel.toMap(favorite),
    );
    return FavoriteModel.fromJson(response.data);
  }

  @override
  Future<Favorite> popFavorite({required Favorite favorite}) async {
    final response = await dio.delete('/favorites/${favorite.id}');
    return FavoriteModel.fromJson(response.data);
  }
}
