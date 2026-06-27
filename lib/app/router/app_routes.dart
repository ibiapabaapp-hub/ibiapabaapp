import 'package:go_router/go_router.dart';
import 'package:ibivibe/app/router/app_shell.dart';
import 'package:ibivibe/core/beta/routes/beta_routes.dart';
import 'package:ibivibe/core/settings/routes/settings_routes.dart';
import 'package:ibivibe/features/accounts/presentation/routes/accounts_routes.dart';
import 'package:ibivibe/features/auth/presentation/routes/auth_routes.dart';
import 'package:ibivibe/features/businesses/presentation/routes/businesses_routes.dart';
import 'package:ibivibe/features/cities/presentation/routes/cities_routes.dart';
import 'package:ibivibe/features/events/presentation/routes/events_routes.dart';
import 'package:ibivibe/features/favorites/presentation/routes/favorites_routes.dart';
import 'package:ibivibe/features/home/presentation/routes/home_routes.dart';
import 'package:ibivibe/features/onboarding/presentation/routes/onboarding_routes.dart';
import 'package:ibivibe/features/search/presentation/routes/search_routes.dart';
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
