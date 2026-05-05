import 'package:ibiapabaapp/core/logger/log_tags.dart';

enum FavoriteAction implements LogTag {
  getAllFavoritesByProfile('[GET_ALL_FAVORITES_BY_PROFILE]'),
  pushFavorite('[PUSH_FAVORITE]'),
  popFavorite('[POP_FAVORITE]'),
  loadFavorites('[LOAD_FAVORITES]'),
  restore('[RESTORE]');

  @override
  final String tag;
  const FavoriteAction(this.tag);
}
