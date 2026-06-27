import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ibivibe/features/webviews/presentation/screens/webview_screen.dart';

final List<RouteBase> webviewsRoutes = [
  // ─── WebView ──────────────────────────────────────────────────────
  GoRoute(
    path: '/app/webview',
    builder: (context, state) {
      final extra = state.extra;

      if (extra is! WebViewArgs) {
        return const Scaffold(body: Center(child: Text('Invalid arguments')));
      }

      return WebViewScreen(args: extra);
    },
  ),
];
