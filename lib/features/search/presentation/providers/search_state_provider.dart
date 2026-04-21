import 'package:ibiapabaapp/core/logger/handlers/controller_log_handler.dart';
import 'package:ibiapabaapp/core/logger/log_tags.dart';
import 'package:ibiapabaapp/core/logger/logger.dart';
import 'package:ibiapabaapp/features/search/data/datasources/search_local_storage.dart';
import 'package:ibiapabaapp/features/search/presentation/providers/search_providers.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_state_provider.g.dart';

@riverpod
class SearchState extends _$SearchState with ControllerLogHandler {
  @override
  LogFeature get feature => LogFeature.search;

  @override
  Logger get logger => ref.read(loggerProvider);

  @override
  RecentSearchesData build() {
    return RecentSearchesData(recentSearches: []);
  }

  SearchLocalStorage get _storage => ref.read(searchLocalStorageProvider);

  Future<void> restore() async {
    try {
      final recentSearches = await _storage.getRecentSearches();
      if (!ref.mounted) return;

      state = state.copyWith(recentSearches: recentSearches);
      logControllerSuccess(action: SearchAction.restore);
    } catch (e) {
      logControllerError(action: SearchAction.restore, failure: e);
    }
  }

  // ─── Recent Searches ─────────────────────────────────────────────────────
  Future<void> addRecentSearch(String query) async {
    final cleanQuery = query.trim();
    if (cleanQuery.isEmpty) return;

    final current = List<String>.from(state.recentSearches);
    current.remove(cleanQuery);
    current.insert(0, cleanQuery);

    if (current.length > 10) {
      current.removeLast();
    }

    await _storage.saveRecentSearches(current);
    state = state.copyWith(recentSearches: current);
  }

  Future<void> clearRecentSearches() async {
    await _storage.saveRecentSearches([]);
    state = state.copyWith(recentSearches: []);
  }

  Future<void> removeRecentSearch(String query) async {
    final cleanQuery = query.trim();
    if (cleanQuery.isEmpty) return;

    final current = List<String>.from(state.recentSearches);
    if (current.remove(cleanQuery)) {
      await _storage.saveRecentSearches(current);
      state = state.copyWith(recentSearches: current);
    }
  }
}

class RecentSearchesData {
  final List<String> recentSearches;

  RecentSearchesData({required this.recentSearches});

  RecentSearchesData copyWith({List<String>? recentSearches}) {
    return RecentSearchesData(
      recentSearches: recentSearches ?? this.recentSearches,
    );
  }
}
