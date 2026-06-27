import 'package:ibivibe/core/location/presentation/providers/location_state_provider.dart';
import 'package:ibivibe/core/logger/handlers/controller_log_handler.dart';
import 'package:ibivibe/core/logger/log_tags.dart';
import 'package:ibivibe/core/logger/logger.dart';
import 'package:ibivibe/core/preferences/user_preferences_state_provider.dart';
import 'package:ibivibe/core/session/app_session.dart';
import 'package:ibivibe/core/session/app_session_logtags.dart';
import 'package:ibivibe/features/auth/presentation/providers/auth_state_provider.dart';
import 'package:ibivibe/features/favorites/presentation/providers/favorites_state_provider.dart';
import 'package:ibivibe/features/search/presentation/providers/search_state_provider.dart';
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
    final searches = ref.watch(searchStateProvider);
    final location = ref.watch(locationStateProvider);
    ref.watch(favoritesStateProvider);

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
        ref.read(authStateProvider.notifier).restore(),
        ref.read(userPreferencesStateProvider.notifier).restore(),
        ref.read(locationStateProvider.notifier).restore(),
        ref.read(searchStateProvider.notifier).restore(),
      ]);

      await ref.read(favoritesStateProvider.notifier).restore();
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
