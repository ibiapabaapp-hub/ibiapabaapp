import 'package:go_router/go_router.dart';
import 'package:ibivibe/app/router/transitions/shared_axis_page.dart';
import 'package:ibivibe/features/favorites/presentation/screens/favorites_screen.dart';

List<RouteBase> favoritesRoutes = [
  // ─── Home > Favorites ──────────────────────────────────────────────
  GoRoute(
    path: '/app/favorites',
    pageBuilder: (context, state) => SharedAxisPage(
      key: state.pageKey,
      type: .scaled,
      child: const FavoritesScreen(),
    ),
  ),
];
