import 'package:ibivibe/core/errors/failures/failures.dart';
import 'package:ibivibe/core/logger/handlers/controller_log_handler.dart';
import 'package:ibivibe/core/logger/log_tags.dart';
import 'package:ibivibe/core/logger/logger.dart';
import 'package:ibivibe/features/favorites/models/favorite.dart';
import 'package:ibivibe/features/favorites/favorites_logtags.dart'
    as fav_tags;
import 'package:ibivibe/features/favorites/presentation/providers/favorites_providers.dart';
import 'package:ibivibe/shared/providers/accounts_state_provider.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'favorites_state_provider.g.dart';

@riverpod
class FavoritesState extends _$FavoritesState with ControllerLogHandler {
  @override
  late final Logger logger = ref.read(loggerProvider);

  @override
  LogFeature get feature => LogFeature.favorites;

  @override
  FavoritesStateData build() {
    ref.listen(accountsStateProvider, (previous, next) {
      if (next.activeAccount != null &&
          previous?.activeAccount?.id != next.activeAccount?.id) {
        _onActiveAccountChanged(next.activeAccount!.id);
      }
    });

    return const FavoritesStateData();
  }

  Future<void> _onActiveAccountChanged(String accountId) async {
    await _loadFavoritesForAccount(accountId);
  }

  Future<void> _loadFavoritesForAccount(String accountId) async {
    try {
      final result = await ref
          .read(favoritesRepositoryProvider)
          .getAllFavoritesByAccount(accountId: accountId);

      if (!ref.mounted) return;

      state = FavoritesStateData(favorites: result);
      logControllerSuccess(action: fav_tags.FavoriteAction.loadFavorites);
    } catch (e, s) {
      final failure = e is AppFailure ? e : InternalFailure(e.toString());
      state = FavoritesStateData(failure: failure);
      logControllerError(
        action: fav_tags.FavoriteAction.loadFavorites,
        failure: failure,
        stackTrace: s,
      );
    }
  }

  Future<void> restore() async {
    try {
      final accountsState = ref.read(accountsStateProvider);
      if (accountsState.activeAccount == null) return;

      await _loadFavoritesForAccount(accountsState.activeAccount!.id);
      if (!state.hasError) {
        logControllerSuccess(action: fav_tags.FavoriteAction.restore);
      }
    } catch (e, s) {
      logControllerError(
        action: fav_tags.FavoriteAction.restore,
        failure: e,
        stackTrace: s,
      );
    }
  }

  Future<void> pushFavorite(Favorite favorite) async {
    try {
      final accountsState = ref.read(accountsStateProvider);
      if (accountsState.activeAccount == null) return;

      final result = await ref
          .read(favoritesRepositoryProvider)
          .pushFavorite(favorite: favorite);

      if (!ref.mounted) return;

      final updatedFavorites = [...state.favorites, result];
      state = FavoritesStateData(favorites: updatedFavorites);
      logControllerSuccess(action: fav_tags.FavoriteAction.pushFavorite);
    } catch (e, s) {
      final failure = e is AppFailure ? e : const InternalFailure('Erro ao adicionar favorito');
      state = FavoritesStateData(favorites: state.favorites, failure: failure);
      logControllerError(
        action: fav_tags.FavoriteAction.pushFavorite,
        failure: failure,
        stackTrace: s,
      );
    }
  }

  Future<void> popFavorite(Favorite favorite) async {
    try {
      final accountsState = ref.read(accountsStateProvider);
      if (accountsState.activeAccount == null) return;

      final result = await ref
          .read(favoritesRepositoryProvider)
          .popFavorite(favorite: favorite);

      if (!ref.mounted) return;

      final updatedFavorites = state.favorites
          .where((f) => f.id != result.id)
          .toList();
      state = FavoritesStateData(favorites: updatedFavorites);
      logControllerSuccess(action: fav_tags.FavoriteAction.popFavorite);
    } catch (e, s) {
      final failure = e is AppFailure ? e : const InternalFailure('Erro ao remover favorito');
      state = FavoritesStateData(favorites: state.favorites, failure: failure);
      logControllerError(
        action: fav_tags.FavoriteAction.popFavorite,
        failure: failure,
        stackTrace: s,
      );
    }
  }
}

class FavoritesStateData {
  final List<Favorite> favorites;
  final AppFailure? failure;

  const FavoritesStateData({this.favorites = const [], this.failure});

  bool get hasError => failure != null;

  FavoritesStateData copyWith({
    List<Favorite>? favorites,
    AppFailure? failure,
  }) {
    return FavoritesStateData(
      favorites: favorites ?? this.favorites,
      failure: failure ?? this.failure,
    );
  }
}
