import 'package:go_router/go_router.dart';
import 'package:ibivibe/features/onboarding/screens/business_data_screen.dart';
import 'package:ibivibe/features/welcome/screens/welcome_screen.dart';

final List<RouteBase> welcomeRoutes = [
  GoRoute(path: '/welcome', builder: (context, state) => const WelcomeScreen()),
  // ─── Business Data (Onboarding & reutilizável) ─────────────────────────────
  GoRoute(
    path: '/app/businesses/basic-data',
    builder: (context, state) => const BusinessDataScreen(),
  ),
];
