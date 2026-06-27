import 'package:go_router/go_router.dart';
import 'package:ibivibe/app/router/transitions/fade_through_page.dart';
import 'package:ibivibe/features/onboarding/presentation/screens/google/google_account_type_screen.dart';
import 'package:ibivibe/features/onboarding/presentation/screens/google/google_slug_gender_screen.dart';
import 'package:ibivibe/features/onboarding/presentation/screens/onboarding_newcomer_screen.dart';
import 'package:ibivibe/features/onboarding/presentation/screens/onboarding_screen.dart';

final List<RouteBase> onboardingRoutes = [
  GoRoute(
    path: '/onboarding/newcomer',
    builder: (context, state) => const OnboardingNewcomerScreen(),
  ),
  GoRoute(
    path: '/onboarding/profile-info',
    pageBuilder: (context, state) =>
        FadeThroughPage(child: const OnboardingScreen(), key: state.pageKey),
  ),
  GoRoute(
    path: '/onboarding/profile-select',
    pageBuilder: (context, state) =>
        FadeThroughPage(child: const OnboardingScreen(), key: state.pageKey),
  ),
  GoRoute(
    path: '/onboarding/google-slug-and-gender',
    pageBuilder: (context, state) => FadeThroughPage(
      child: const GoogleSlugGenderScreen(),
      key: state.pageKey,
    ),
  ),
  GoRoute(
    path: '/onboarding/google-account-type',
    pageBuilder: (context, state) => FadeThroughPage(
      child: const GoogleAccountTypeScreen(),
      key: state.pageKey,
    ),
  ),
];
