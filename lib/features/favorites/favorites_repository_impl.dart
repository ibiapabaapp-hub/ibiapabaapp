import 'package:ibivibe/core/logger/handlers/repository_log_handler.dart';
import 'package:ibivibe/core/logger/log_tags.dart';
import 'package:ibivibe/features/favorites/favorites_local_storage.dart';
import 'package:ibivibe/features/favorites/favorites_remote_datasource.dart';
import 'package:ibivibe/features/favorites/models/favorite.dart';
import 'package:ibivibe/features/favorites/favorites_repository.dart';
import 'package:ibivibe/features/favorites/favorites_logtags.dart';
import 'package:logger/logger.dart';

class FavoritesRepositoryImpl
    with RepositoryLogHandler
    implements FavoritesRepository {
  @override
  final Logger logger;
  final FavoritesRemoteDatasource remoteDatasource;
  final FavoritesLocalStorage localStorage;

  FavoritesRepositoryImpl({
    required this.remoteDatasource,
    required this.logger,
    required this.localStorage,
  });

  @override
  LogFeature get feature => LogFeature.favorites;

  @override
  Future<List<Favorite>> getAllFavoritesByAccount({
    required String accountId,
  }) async {
    try {
      final cachedFavorites = await localStorage.loadFavoritesByAccount(
        accountId: accountId,
      );
      if (cachedFavorites.isNotEmpty) return cachedFavorites;

      final result = await remoteDatasource.getAllFavoritesByAccount(
        accountId: accountId,
      );
      await localStorage.saveFavoritesByAccount(
        favorites: result,
        accountId: accountId,
      );
      return result;
    } catch (e, stack) {
      handleRepositoryError(
        exception: e,
        stackTrace: stack,
        action: FavoriteAction.getAllFavoritesByAccount,
      );
      rethrow;
    }
  }

  @override
  Future<Favorite> pushFavorite({
    required Favorite favorite,
  }) async {
    try {
      final result = await remoteDatasource.pushFavorite(favorite: favorite);
      await localStorage.pushFavorite(favorite: result);
      return result;
    } catch (e, stack) {
      handleRepositoryError(
        exception: e,
        stackTrace: stack,
        action: FavoriteAction.pushFavorite,
      );
      rethrow;
    }
  }

  @override
  Future<Favorite> popFavorite({
    required Favorite favorite,
  }) async {
    try {
      final result = await remoteDatasource.popFavorite(favorite: favorite);
      await localStorage.popFavorite(favorite: favorite);
      return result;
    } catch (e, stack) {
      handleRepositoryError(
        exception: e,
        stackTrace: stack,
        action: FavoriteAction.popFavorite,
      );
      rethrow;
    }
  }
}
