import 'package:go_router/go_router.dart';
import 'package:ibiapabaapp/app/router/transitions/fade_through_page.dart';
import 'package:ibiapabaapp/app/router/transitions/shared_axis_page.dart';
import 'package:ibiapabaapp/features/home/presentation/screens/home_screen.dart';
import 'package:ibiapabaapp/core/beta/presentation/screens/under_development_screen.dart';

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
