import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ibiapabaapp/app/router/transitions/shared_axis_page.dart';
import 'package:ibiapabaapp/features/search/presentation/screens/expanded_search_screen.dart';
import 'package:ibiapabaapp/features/search/presentation/screens/search_screen.dart';

final List<RouteBase> searchRoutes = [
  // ─── Home > Search ─────────────────────────────────────────────────
  GoRoute(
    path: '/app/search',
    pageBuilder: (context, state) => SharedAxisPage(
      key: state.pageKey,
      type: .scaled,
      child: const SearchScreen(),
    ),
  ),

  // ─── Home > Search > ExpandedSearch ────────────────────────────────
  GoRoute(
    path: '/app/search/expanded',
    pageBuilder: (context, state) => CustomTransitionPage(
      key: state.pageKey,
      child: const ExpandedSearchScreen(),
      transitionDuration: const Duration(milliseconds: 400),
      reverseTransitionDuration: const Duration(milliseconds: 300),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve: Curves.easeOut,
            reverseCurve: Curves.easeIn,
          ),
          child: child,
        );
      },
    ),
  ),
];
