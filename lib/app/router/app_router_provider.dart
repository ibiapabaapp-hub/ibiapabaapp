import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ibivibe/app/router/app_router_redirect_provider.dart';
import 'package:ibivibe/app/router/app_routes.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router_provider.g.dart';

@riverpod
GoRouter appRouter(Ref ref) {
  final notifier = ValueNotifier<Object?>(null);
  ref.listen(routerRedirectProvider, (_, _) => notifier.value = Object());

  final router = GoRouter(
    initialLocation: '/app/home',
    refreshListenable: notifier,
    redirect: (context, state) {
      final target = ref.read(routerRedirectProvider);
      final loc = state.matchedLocation;

      final isInAuthFlow =
          loc.startsWith('/welcome') ||
          loc.startsWith('/auth') ||
          loc.startsWith('/onboarding');

      return switch (target) {
        RedirectTarget.loading => isInAuthFlow ? null : '/loading',
        RedirectTarget.welcome => isInAuthFlow ? null : '/welcome',
        RedirectTarget.onboarding =>
          isInAuthFlow ? null : '/onboarding/newcomer',
        RedirectTarget.home => isInAuthFlow ? '/app/home' : null,
        RedirectTarget.none => null,
      };
    },
    routes: appRoutes,
  );
  ref.onDispose(notifier.dispose);

  return router;
}
