import 'package:go_router/go_router.dart';
import 'package:ibivibe/app/router/app_shell.dart';
import 'package:ibivibe/core/beta/routes/beta_routes.dart';
import 'package:ibivibe/core/settings/routes/settings_routes.dart';
import 'package:ibivibe/features/accounts/routes/accounts_routes.dart';
import 'package:ibivibe/features/auth/routes/auth_routes.dart';
import 'package:ibivibe/features/businesses/routes/businesses_routes.dart';
import 'package:ibivibe/features/cities/routes/cities_routes.dart';
import 'package:ibivibe/features/events/routes/events_routes.dart';
import 'package:ibivibe/features/favorites/routes/favorites_routes.dart';
import 'package:ibivibe/features/home/routes/home_routes.dart';
import 'package:ibivibe/features/onboarding/routes/onboarding_routes.dart';
import 'package:ibivibe/features/search/routes/search_routes.dart';
import 'package:ibivibe/features/webviews/routes/webviews_routes.dart';
import 'package:ibivibe/features/welcome/routes/welcome_routes.dart';

final List<RouteBase> appRoutes = [
  ...betaRoutes,
  ...welcomeRoutes,
  ...authRoutes,
  ...onboardingRoutes,

  ShellRoute(
    builder: (context, state, child) => AppShell(child: child),
    routes: [
      ...accountsRoutes,
      ...searchRoutes,
      ...favoritesRoutes,
      ...webviewsRoutes,
      ...homeRoutes,
      ...citiesRoutes,
      ...businessesRoutes,
      ...eventsRoutes,
      ...settingsRoutes,
    ],
  ),
];
