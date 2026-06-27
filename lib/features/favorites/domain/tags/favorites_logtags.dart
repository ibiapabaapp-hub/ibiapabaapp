import 'package:ibivibe/core/logger/log_tags.dart';

enum FavoriteAction implements LogTag {
  getAllFavoritesByAccount('[GET_ALL_FAVORITES_BY_ACCOUNT]'),
  pushFavorite('[PUSH_FAVORITE]'),
  popFavorite('[POP_FAVORITE]'),
  loadFavorites('[LOAD_FAVORITES]'),
  restore('[RESTORE]');

  @override
  final String tag;
  const FavoriteAction(this.tag);
}
