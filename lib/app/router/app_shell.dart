import 'dart:io';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ibivibe/shared/ui/fragments/inputs/navbar.dart';
import 'package:ibivibe/shared/ui/fragments/toast/show_app_toast.dart';

class AppShell extends ConsumerStatefulWidget {
  final Widget child;
  const AppShell({super.key, required this.child});

  @override
  ConsumerState<AppShell> createState() => _AppShellState();
}

class _AppShellState extends ConsumerState<AppShell> {
  DateTime? _lastBackPressed;

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final locationIsHome = location == '/app/home';

    final routesWithoutNavbar = [
      '/app/businesses',
      '/app/cities',
      '/app/events',
      '/app/search/expanded',
      '/app/settings',
      '/app/beta',
      '/app/webview',
      '/app/accounts/manage',
    ];

    final bool hideNavbar = routesWithoutNavbar.any(
      (path) => location.startsWith(path),
    );

    return PopScope(
      canPop: !locationIsHome,
      onPopInvokedWithResult: (didPop, _) {
        if (!locationIsHome || didPop) return;

        final now = DateTime.now();

        if (_lastBackPressed == null ||
            now.difference(_lastBackPressed!) > const Duration(seconds: 2)) {
          _lastBackPressed = now;

          showAppToast(
            duration: const Duration(seconds: 3),
            alignment: .bottomCenter,
            context: context,
            title: 'Volte novamente para sair',
          );
        } else {
          exit(0);
        }
      },
      child: SafeArea(
        top: false,
        child: Scaffold(
          extendBody: true,
          bottomNavigationBar: PageTransitionSwitcher(
            duration: const Duration(milliseconds: 300),
            reverse: hideNavbar,
            transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
              return FadeThroughTransition(
                animation: primaryAnimation,
                secondaryAnimation: secondaryAnimation,
                child: child,
              );
            },
            child: hideNavbar
                ? const SizedBox.shrink()
                : const SafeArea(key: ValueKey('navbar'), child: Navbar()),
          ),
          body: widget.child,
        ),
      ),
    );
  }
}
