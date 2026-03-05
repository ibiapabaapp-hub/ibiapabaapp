import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ibiapabaapp/app/router/transitions/fade_through_page.dart';
import 'package:ibiapabaapp/app/router/transitions/shared_axis_page.dart';
import 'package:ibiapabaapp/features/auth/presentation/providers/session_provider.dart';
import 'package:ibiapabaapp/features/cities/presentation/screens/cities_overview_screen.dart';
import 'package:ibiapabaapp/features/cities/presentation/screens/single_city_screen.dart';
import 'package:ibiapabaapp/features/company/presentation/screens/companies_overview_screen.dart';
import 'package:ibiapabaapp/features/company/presentation/screens/single_company_screen.dart';
import 'package:ibiapabaapp/features/events/presentation/screens/events_overview_screen.dart';
import 'package:ibiapabaapp/features/events/presentation/screens/single_event_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:ibiapabaapp/app/router/app_shell.dart';
import 'package:ibiapabaapp/features/home/presentation/screens/home_screen.dart';
import 'package:ibiapabaapp/features/home/presentation/screens/search_screen.dart';
import 'package:ibiapabaapp/features/onboarding/company_onboarding_screen.dart';
import 'package:ibiapabaapp/features/onboarding/user_onboarding_screen.dart';
import 'package:ibiapabaapp/features/auth/presentation/screens/register_screen.dart';
import 'package:ibiapabaapp/features/profile/presentation/screens/profile_screen.dart';
import 'package:ibiapabaapp/features/welcome/welcome_screen.dart';

part 'app_router_provider.g.dart';

@riverpod
GoRouter appRouter(Ref ref) {
  final isAuthenticated = ref.watch(isAuthenticatedProvider);

  return GoRouter(
    initialLocation: '/app/home',
    redirect: (context, state) {
      final isLoggingIn =
          state.matchedLocation.startsWith('/welcome') ||
          state.matchedLocation.startsWith('/auth');

      // não está logado e tenta acessar área restrita -> Welcome
      if (!isAuthenticated) {
        return isLoggingIn ? null : '/welcome';
      }

      // está logado e tenta acessar área de login -> Home
      if (isLoggingIn) {
        return '/app/home';
      }

      return null;
    },
    routes: [
      // ===================== Welcome & Onboarding =====================
      GoRoute(
        path: '/welcome',
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: '/onboarding/user',
        builder: (context, state) => const UserOnboardingScreen(),
      ),
      GoRoute(
        path: '/onboarding/company',
        builder: (context, state) => const CompanyOnboardingScreen(),
      ),

      // ===================== Authentication =====================
      GoRoute(
        path: '/auth/register',
        builder: (context, state) => const RegisterScreen(),
      ),

      // ===================== AppShell =====================
      ShellRoute(
        builder: (context, state, child) => AppShell(child: child),
        routes: [
          // ===================== Navbar =====================
          GoRoute(
            path: '/app/home',
            pageBuilder: (context, state) =>
                FadeThroughPage(key: state.pageKey, child: const HomeScreen()),
          ),
          GoRoute(
            path: '/app/search',
            pageBuilder: (context, state) => FadeThroughPage(
              key: state.pageKey,
              child: const SearchScreen(),
            ),
          ),
          GoRoute(
            path: '/app/favorites',
            pageBuilder: (context, state) => FadeThroughPage(
              key: state.pageKey,
              child: const Placeholder(child: Text("Favorites")),
            ),
          ),
          GoRoute(
            path: '/app/profile',
            pageBuilder: (context, state) =>
                FadeThroughPage(key: state.pageKey, child: ProfileScreen()),
          ),

          // ===================== Cities =====================
          GoRoute(
            path: '/app/cities',
            pageBuilder: (context, state) => FadeThroughPage(
              key: state.pageKey,
              child: CitiesOverviewScreen(),
            ),
            routes: [
              GoRoute(
                path: ':id',
                pageBuilder: (context, state) => SharedAxisPage(
                  key: state.pageKey,
                  child: SingleCityScreen(
                    id: state.pathParameters['id'].toString(),
                  ),
                  type: SharedAxisTransitionType.scaled,
                  duration: const Duration(milliseconds: 500),
                ),
              ),
            ],
          ),

          // ===================== Companies =====================
          GoRoute(
            path: '/app/companies',
            pageBuilder: (context, state) => FadeThroughPage(
              key: state.pageKey,
              child: CompaniesOverviewScreen(),
            ),
            routes: [
              GoRoute(
                path: '/:id',
                pageBuilder: (context, state) => SharedAxisPage(
                  key: state.pageKey,
                  child: SingleCompanyScreen(
                    id: state.pathParameters['id'].toString(),
                  ),
                  type: SharedAxisTransitionType.scaled,
                  duration: const Duration(milliseconds: 500),
                ),
              ),
            ],
          ),

          // ===================== Events =====================
          GoRoute(
            path: '/app/events',
            pageBuilder: (context, state) => FadeThroughPage(
              key: state.pageKey,
              child: EventsOverviewScreen(),
            ),
            routes: [
              GoRoute(
                path: '/:id',
                pageBuilder: (context, state) => SharedAxisPage(
                  key: state.pageKey,
                  child: SingleEventScreen(
                    id: state.pathParameters['id'].toString(),
                  ),
                  type: SharedAxisTransitionType.scaled,
                  duration: const Duration(milliseconds: 500),
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
