import 'package:ibivibe/core/location/presentation/providers/location_state_provider.dart';
import 'package:ibivibe/core/logger/handlers/controller_log_handler.dart';
import 'package:ibivibe/core/logger/log_tags.dart';
import 'package:ibivibe/core/logger/logger.dart';
import 'package:ibivibe/core/preferences/user_preferences_state_provider.dart';
import 'package:ibivibe/core/session/app_session.dart';
import 'package:ibivibe/core/session/app_session_logtags.dart';
import 'package:ibivibe/features/auth/auth_viewmodel.dart';
import 'package:ibivibe/features/favorites/favorites_viewmodel.dart';
import 'package:ibivibe/features/search/search_viewmodel.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_session_notifier_provider.g.dart';

@Riverpod(keepAlive: true)
class AppSessionNotifier extends _$AppSessionNotifier
    with ControllerLogHandler {
  @override
  late final Logger logger = ref.read(loggerProvider);

  @override
  LogFeature get feature => LogFeature.session;

  @override
  AppSession build() {
    final preferences = ref.watch(userPreferencesStateProvider);
    final searches = ref.watch(searchViewModelProvider);
    final location = ref.watch(locationStateProvider);
    ref.watch(favoritesViewModelProvider);

    return AppSession(
      themeMode: preferences.themeMode,
      needsOnboarding: preferences.needsOnboarding,
      recentSearches: searches.recentSearches,
      currentCity: location.currentCity,
    );
  }

  Future<void> restore() async {
    try {
      await Future.wait([
        ref.read(authViewModelProvider.notifier).restore(),
        ref.read(userPreferencesStateProvider.notifier).restore(),
        ref.read(locationStateProvider.notifier).restore(),
        ref.read(searchViewModelProvider.notifier).restore(),
      ]);

      await ref.read(favoritesViewModelProvider.notifier).restore();
      await Future.microtask(ref.invalidateSelf);

      logControllerSuccess(action: AppSessionAction.restore);
    } catch (e, s) {
      logControllerError(
        action: AppSessionAction.restore,
        failure: e,
        stackTrace: s,
      );
    }
  }
}
