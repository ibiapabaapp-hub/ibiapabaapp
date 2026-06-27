import 'package:go_router/go_router.dart';
import 'package:ibivibe/features/onboarding/presentation/screens/business_data_screen.dart';
import 'package:ibivibe/features/welcome/welcome_screen.dart';

final List<RouteBase> welcomeRoutes = [
  GoRoute(path: '/welcome', builder: (context, state) => const WelcomeScreen()),
  // ─── Business Data (Onboarding & reutilizável) ─────────────────────────────
  GoRoute(
    path: '/app/businesses/basic-data',
    builder: (context, state) => const BusinessDataScreen(),
  ),
];
