import 'package:animations/animations.dart';
import 'package:go_router/go_router.dart';
import 'package:ibiapabaapp/app/router/transitions/shared_axis_page.dart';
import 'package:ibiapabaapp/features/accounts/presentation/screens/account_screen.dart';
import 'package:ibiapabaapp/features/accounts/presentation/screens/interests/account_businesses_interests_screen.dart';
import 'package:ibiapabaapp/features/accounts/presentation/screens/interests/account_events_interests_screen.dart';
import 'package:ibiapabaapp/features/accounts/presentation/screens/manage_accounts_screen.dart';

final List<RouteBase> accountsRoutes = [
  GoRoute(
    path: '/app/accounts',
    pageBuilder: (context, state) => SharedAxisPage(
      key: state.pageKey,
      child: const AccountScreen(),
      type: SharedAxisTransitionType.scaled,
      duration: const Duration(milliseconds: 500),
    ),
  ),

  GoRoute(
    path: '/app/accounts/interests/businesses',
    pageBuilder: (context, state) => SharedAxisPage(
      key: state.pageKey,
      child: const AccountBusinessesInterestsScreen(),
      type: SharedAxisTransitionType.scaled,
      duration: const Duration(milliseconds: 500),
    ),
  ),

  GoRoute(
    path: '/app/accounts/interests/events',
    pageBuilder: (context, state) => SharedAxisPage(
      key: state.pageKey,
      child: const AccountEventsInterestsScreen(),
      type: SharedAxisTransitionType.horizontal,
      duration: const Duration(milliseconds: 500),
    ),
  ),

  GoRoute(
    path: '/app/accounts/manage',
    pageBuilder: (context, state) => SharedAxisPage(
      key: state.pageKey,
      child: const ManageAccountsScreen(),
      type: SharedAxisTransitionType.scaled,
      duration: const Duration(milliseconds: 500),
    ),
  ),
];
