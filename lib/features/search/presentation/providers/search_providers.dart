import 'package:ibiapabaapp/core/cache/cache_database_provider.dart';
import 'package:ibiapabaapp/core/network/dio_provider.dart';
import 'package:ibiapabaapp/features/search/data/datasources/search_remote_datasource.dart';
import 'package:ibiapabaapp/features/search/data/datasources/search_local_storage.dart';
import 'package:ibiapabaapp/features/search/infra/search_local_storage_impl.dart';
import 'package:ibiapabaapp/features/search/data/repositories/search_repository_impl.dart';
import 'package:ibiapabaapp/features/search/domain/entities/search_result.dart';
import 'package:ibiapabaapp/features/search/domain/repositories/search_repository.dart';
import 'package:ibiapabaapp/features/search/infra/search_remote_datasource_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_providers.g.dart';

@riverpod
SearchLocalStorage searchLocalStorage(Ref ref) {
  final cacheService = ref.watch(cacheDatabaseServiceProvider);
  return SearchLocalStorageImpl(cacheService);
}

@riverpod
SearchRemoteDatasource searchRemoteDatasource(Ref ref) {
  final dio = ref.watch(dioProvider);
  return SearchRemoteDataSourceImpl(dio);
}

@riverpod
SearchRepository searchRepository(Ref ref) {
  final remoteDataSource = ref.watch(searchRemoteDatasourceProvider);
  return SearchRepositoryImpl(remoteDataSource);
}

@riverpod
class SearchNotifier extends _$SearchNotifier {
  @override
  FutureOr<List<SearchResult>> build() {
    return [];
  }

  Future<void> search(String query) async {
    if (query.isEmpty) {
      state = const AsyncValue.data([]);
      return;
    }

    state = const AsyncValue.loading();

    try {
      final repository = ref.read(searchRepositoryProvider);
      final results = await repository.search(query);
      state = AsyncValue.data(results);
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }
}
