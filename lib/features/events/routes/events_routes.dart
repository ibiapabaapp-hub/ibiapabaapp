import 'package:animations/animations.dart';
import 'package:go_router/go_router.dart';
import 'package:ibivibe/app/router/transitions/fade_through_page.dart';
import 'package:ibivibe/app/router/transitions/shared_axis_page.dart';
import 'package:ibivibe/features/events/screens/event_detail_screen.dart';
import 'package:ibivibe/features/events/screens/events_overview_screen.dart';

final List<RouteBase> eventsRoutes = [
  // ─── Events ────────────────────────────────────────────────────────────────
  GoRoute(
    path: '/app/events',
    pageBuilder: (context, state) =>
        FadeThroughPage(key: state.pageKey, child: const EventsOverviewScreen()),
    routes: [
      // ─── Events > :id ──────────────────────────────────────────────────────
      GoRoute(
        path: ':id',
        pageBuilder: (context, state) => SharedAxisPage(
          key: state.pageKey,
          child: EventDetailScreen(id: state.pathParameters['id'].toString()),
          type: SharedAxisTransitionType.scaled,
          duration: const Duration(milliseconds: 500),
        ),
      ),
    ],
  ),
];
