import 'package:dio/dio.dart';
import 'package:ibivibe/features/favorites/data/datasources/favorites_remote_datasource.dart';
import 'package:ibivibe/features/favorites/domain/entities/favorite.dart';
import 'package:ibivibe/features/favorites/infra/models/favorite_model.dart';

class FavoritesRemoteDatasourceImpl implements FavoritesRemoteDatasource {
  final Dio dio;

  FavoritesRemoteDatasourceImpl(this.dio);

  @override
  Future<List<Favorite>> getAllFavoritesByAccount({
    required String accountId,
  }) async {
    final response = await dio.get(
      '/favorites',
      queryParameters: {'account_id': accountId},
    );
    return FavoriteModel.fromJsonList(response.data);
  }

  @override
  Future<Favorite> pushFavorite({required Favorite favorite}) async {
    final response = await dio.post(
      '/favorites',
      data: FavoriteModel.mapPush(favorite),
    );
    return FavoriteModel.fromJson(response.data);
  }

  @override
  Future<Favorite> popFavorite({required Favorite favorite}) async {
    final response = await dio.delete('/favorites/${favorite.id}');
    return FavoriteModel.fromJson(response.data);
  }
}
