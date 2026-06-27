import 'package:go_router/go_router.dart';
import 'package:ibivibe/app/router/transitions/fade_through_page.dart';
import 'package:ibivibe/app/router/transitions/shared_axis_page.dart';
import 'package:ibivibe/features/home/presentation/screens/home_screen.dart';
import 'package:ibivibe/core/beta/presentation/screens/under_development_screen.dart';

final List<RouteBase> homeRoutes = [
  // ─── Home ──────────────────────────────────────────────────────────
  GoRoute(
    path: '/app/home',
    pageBuilder: (context, state) => SharedAxisPage(
      key: state.pageKey,
      type: .scaled,
      child: const HomeScreen(),
    ),
  ),

  // ─── Home > Under Development ──────────────────────────────────────
  GoRoute(
    path: '/app/beta/under-development',
    pageBuilder: (context, state) {
      final args = state.extra as UnderDevelopmentArgs?;
      return FadeThroughPage(
        key: state.pageKey,
        child: UnderDevelopmentScreen(
          featureName: args?.featureName,
          featureDescription: args?.featureDescription,
          featureIcon: args?.featureIcon,
        ),
      );
    },
  ),
];
