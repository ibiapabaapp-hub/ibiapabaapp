import 'package:animations/animations.dart';
import 'package:go_router/go_router.dart';
import 'package:ibiapabaapp/app/router/transitions/shared_axis_page.dart';
import 'package:ibiapabaapp/features/auth/presentation/screens/login_screen.dart';
import 'package:ibiapabaapp/features/auth/presentation/screens/register_screen.dart';

final List<RouteBase> authRoutes = [
  GoRoute(
    path: '/auth/register',
    pageBuilder: (context, state) => SharedAxisPage(
      key: state.pageKey,
      child: const RegisterScreen(),
      type: SharedAxisTransitionType.scaled,
      duration: const Duration(milliseconds: 500),
    ),
  ),
  GoRoute(
    path: '/auth/login',
    pageBuilder: (context, state) => SharedAxisPage(
      key: state.pageKey,
      child: const LoginScreen(),
      type: SharedAxisTransitionType.scaled,
      duration: const Duration(milliseconds: 500),
    ),
  ),
];
