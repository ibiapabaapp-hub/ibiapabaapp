import 'package:animations/animations.dart';
import 'package:go_router/go_router.dart';
import 'package:ibivibe/app/router/transitions/fade_through_page.dart';
import 'package:ibivibe/app/router/transitions/shared_axis_page.dart';
import 'package:ibivibe/features/cities/screens/cities_overview_screen.dart';
import 'package:ibivibe/features/cities/screens/city_detail_screen.dart';

final List<RouteBase> citiesRoutes = [
  // ─── Cities ────────────────────────────────────────────────────────────────
  GoRoute(
    path: '/app/cities',
    pageBuilder: (context, state) =>
        FadeThroughPage(key: state.pageKey, child: const CitiesOverviewScreen()),
    routes: [
      // ─── Cities > :id ──────────────────────────────────────────────────────
      GoRoute(
        path: ':id',
        pageBuilder: (context, state) => SharedAxisPage(
          key: state.pageKey,
          child: CityDetailScreen(id: state.pathParameters['id'].toString()),
          type: SharedAxisTransitionType.scaled,
          duration: const Duration(milliseconds: 500),
        ),
      ),
    ],
  ),
];
