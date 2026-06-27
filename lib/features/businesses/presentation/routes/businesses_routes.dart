import 'package:animations/animations.dart';
import 'package:go_router/go_router.dart';
import 'package:ibiapabaapp/app/router/transitions/fade_through_page.dart';
import 'package:ibiapabaapp/app/router/transitions/shared_axis_page.dart';
import 'package:ibiapabaapp/features/businesses/presentation/screens/business_detail_screen.dart';
import 'package:ibiapabaapp/features/businesses/presentation/screens/businesses_overview_screen.dart';

final List<RouteBase> businessesRoutes = [
  // ─── Businesses ─────────────────────────────────────────────────────
  GoRoute(
    path: '/app/businesses',
    pageBuilder: (context, state) =>
        FadeThroughPage(key: state.pageKey, child: const BusinessesOverviewScreen()),
    routes: [
      // ─── Businesses > :id ──────────────────────────────────────────────────
      GoRoute(
        path: ':id',
        pageBuilder: (context, state) => SharedAxisPage(
          key: state.pageKey,
          child: BusinessDetailScreen(
            id: state.pathParameters['id'].toString(),
          ),
          type: SharedAxisTransitionType.scaled,
          duration: const Duration(milliseconds: 500),
        ),
      ),
    ],
  ),
];
