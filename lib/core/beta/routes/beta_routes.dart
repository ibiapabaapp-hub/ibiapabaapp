import 'package:animations/animations.dart';
import 'package:go_router/go_router.dart';
import 'package:ibiapabaapp/app/router/transitions/loading_screen.dart';
import 'package:ibiapabaapp/app/router/transitions/shared_axis_page.dart';
import 'package:ibiapabaapp/core/beta/presentation/screens/under_development_screen.dart';

final List<RouteBase> betaRoutes = [
  GoRoute(
    path: '/app/beta/under-development',
    builder: (context, state) => const UnderDevelopmentScreen(),
  ),
  GoRoute(
    path: '/loading',
    pageBuilder: (context, state) {
      final extra = state.extra as Map<String, dynamic>?;
      final message = extra?['message'] as String?;
      final messages = extra?['messages'] as List<String>?;
      return SharedAxisPage(
        key: state.pageKey,
        child: LoadingScreen(message: message, messages: messages),
        type: SharedAxisTransitionType.scaled,
        duration: const Duration(milliseconds: 500),
      );
    },
  ),
];
