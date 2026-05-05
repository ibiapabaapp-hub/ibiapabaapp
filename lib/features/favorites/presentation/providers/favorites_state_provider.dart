import 'package:ibiapabaapp/core/errors/failures/failures.dart';
import 'package:ibiapabaapp/core/logger/handlers/controller_log_handler.dart';
import 'package:ibiapabaapp/core/logger/log_tags.dart';
import 'package:ibiapabaapp/core/logger/logger.dart';
import 'package:ibiapabaapp/features/favorites/domain/entities/favorite.dart';
import 'package:ibiapabaapp/features/favorites/domain/tags/favorites_logtags.dart'
    as fav_tags;
import 'package:ibiapabaapp/features/favorites/domain/usecases/get_all_favorites_by_profile.dart';
import 'package:ibiapabaapp/features/favorites/domain/usecases/pop_favorite.dart';
import 'package:ibiapabaapp/features/favorites/domain/usecases/push_favorite.dart';
import 'package:ibiapabaapp/features/favorites/presentation/providers/favorites_providers.dart';
import 'package:ibiapabaapp/features/profiles/presentation/providers/profile_state_provider.dart';
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
    ref.listen(profileStateProvider, (previous, next) {
      if (next.activeProfile != null &&
          previous?.activeProfile?.id != next.activeProfile?.id) {
        _onActiveProfileChanged(next.activeProfile!.id);
      }
    });

    return const FavoritesStateData();
  }

  Future<void> _onActiveProfileChanged(String profileId) async {
    await _loadFavoritesForProfile(profileId);
  }

  Future<void> _loadFavoritesForProfile(String profileId) async {
    try {
      final result = await ref
          .read(getAllFavoritesByProfileProvider)
          .call(GetAllFavoritesByProfileParams(profileId: profileId));

      if (!ref.mounted) return;

      result.fold(
        (failure) {
          state = FavoritesStateData(failure: failure);
          logControllerError(
            action: fav_tags.FavoriteAction.loadFavorites,
            failure: failure,
          );
        },
        (favorites) {
          state = FavoritesStateData(favorites: favorites);
          logControllerSuccess(action: fav_tags.FavoriteAction.loadFavorites);
        },
      );
    } catch (e, s) {
      logControllerError(
        action: fav_tags.FavoriteAction.loadFavorites,
        failure: e,
        stackTrace: s,
      );
    }
  }

  Future<void> restore() async {
    try {
      final profileState = ref.read(profileStateProvider);
      if (profileState.activeProfile == null) return;

      await _loadFavoritesForProfile(profileState.activeProfile!.id);
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
      final profileState = ref.read(profileStateProvider);
      if (profileState.activeProfile == null) return;

      final result = await ref
          .read(pushFavoriteProvider)
          .call(PushFavoriteParams(favorite: favorite));

      if (!ref.mounted) return;

      result.fold(
        (failure) {
          state = FavoritesStateData(
            favorites: state.favorites,
            failure: failure,
          );
          logControllerError(
            action: fav_tags.FavoriteAction.pushFavorite,
            failure: failure,
          );
        },
        (favorite) {
          final updatedFavorites = [...state.favorites, favorite];
          state = FavoritesStateData(favorites: updatedFavorites);
          logControllerSuccess(action: fav_tags.FavoriteAction.pushFavorite);
        },
      );
    } catch (e, s) {
      final failure = const InternalFailure('Erro ao adicionar favorito');
      state = FavoritesStateData(favorites: state.favorites, failure: failure);
      logControllerError(
        action: fav_tags.FavoriteAction.pushFavorite,
        failure: e,
        stackTrace: s,
      );
    }
  }

  Future<void> popFavorite(Favorite favorite) async {
    try {
      final profileState = ref.read(profileStateProvider);
      if (profileState.activeProfile == null) return;

      final result = await ref
          .read(popFavoriteProvider)
          .call(PopFavoriteParams(favorite: favorite));

      if (!ref.mounted) return;

      result.fold(
        (failure) {
          state = FavoritesStateData(
            favorites: state.favorites,
            failure: failure,
          );
          logControllerError(
            action: fav_tags.FavoriteAction.popFavorite,
            failure: failure,
          );
        },
        (favorite) {
          final updatedFavorites = state.favorites
              .where((f) => f.id != favorite.id)
              .toList();
          state = FavoritesStateData(favorites: updatedFavorites);
          logControllerSuccess(action: fav_tags.FavoriteAction.popFavorite);
        },
      );
    } catch (e, s) {
      final failure = const InternalFailure('Erro ao remover favorito');
      state = FavoritesStateData(favorites: state.favorites, failure: failure);
      logControllerError(
        action: fav_tags.FavoriteAction.popFavorite,
        failure: e,
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
