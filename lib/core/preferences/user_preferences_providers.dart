import 'package:ibiapabaapp/core/cache/cache_database_provider.dart';
import 'package:ibiapabaapp/core/preferences/user_preferences_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_preferences_providers.g.dart';

@riverpod
UserPreferencesStorage userPreferencesStorage(Ref ref) {
  final service = ref.watch(cacheDatabaseServiceProvider);
  return UserPreferencesStorage(service);
}
