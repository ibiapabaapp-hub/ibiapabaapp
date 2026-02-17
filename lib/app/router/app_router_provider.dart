import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ibiapabaapp/features/auth/presentation/providers/session_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Imports das suas telas
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
      // Welcome & Onboarding
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

      // Authentication
      GoRoute(
        path: '/auth/register',
        builder: (context, state) => const RegisterScreen(),
      ),

      // Application Shell
      ShellRoute(
        builder: (context, state, child) => AppShell(child: child),
        routes: [
          GoRoute(
            path: '/app/home',
            builder: (context, state) => const HomeScreen(),
            routes: [
              GoRoute(
                path: 'details',
                builder: (context, state) =>
                    const Placeholder(child: Text('Details')),
              ),
            ],
          ),
          GoRoute(
            path: '/app/search',
            builder: (context, state) => const SearchScreen(),
          ),
          GoRoute(
            path: '/app/favorites',
            builder: (context, state) =>
                const Placeholder(child: Text("Favorites")),
          ),
          GoRoute(
            path: '/app/profile',
            builder: (context, state) => ProfileScreen(),
          ),
        ],
      ),
    ],
  );
}
