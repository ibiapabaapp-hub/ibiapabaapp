import 'package:go_router/go_router.dart';
import 'package:ibiapabaapp/app/router/transitions/fade_through_page.dart';
import 'package:ibiapabaapp/core/settings/presentation/screens/settings_screen.dart';

final List<RouteBase> settingsRoutes = [
  GoRoute(
    path: '/app/settings',
    pageBuilder: (context, state) =>
        FadeThroughPage(key: state.pageKey, child: const SettingsScreen()),
  ),
];
