import 'package:ibiapabaapp/core/cache/cache_database_provider.dart';
import 'package:ibiapabaapp/core/logger/logger.dart';
import 'package:ibiapabaapp/core/network/dio_provider.dart';
import 'package:ibiapabaapp/features/cities/data/datasource/cities_local_datasource.dart';
import 'package:ibiapabaapp/features/cities/data/datasource/cities_remote_datasource.dart';
import 'package:ibiapabaapp/features/cities/data/repositories/cities_repository_impl.dart';
import 'package:ibiapabaapp/features/cities/domain/entities/city.dart';
import 'package:ibiapabaapp/features/cities/domain/repositories/cities_repository.dart';
import 'package:ibiapabaapp/features/cities/domain/usecases/get_all_cities.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cities_providers.g.dart';

// DATA
@riverpod
CitiesLocalDatasourceImpl citiesLocalDatasource(Ref ref) {
  final database = ref.watch(cacheDatabaseProvider);
  return CitiesLocalDatasourceImpl(cacheDatabase: database);
}

@riverpod
CitiesRemoteDatasource citiesRemoteDatasource(Ref ref) {
  final dio = ref.watch(dioProvider);
  return CitiesRemoteDatasourceImpl(dio);
}

@riverpod
CitiesRepository citiesRepository(Ref ref) {
  final localDatasource = ref.watch(citiesLocalDatasourceProvider);
  final remoteDatasource = ref.watch(citiesRemoteDatasourceProvider);

  return CitiesRepositoryImpl(
    remoteDatasource: remoteDatasource,
    localDatasource: localDatasource,
  );
}

// USECASES
@riverpod
GetAllCities getAllCities(Ref ref) {
  final repository = ref.watch(citiesRepositoryProvider);
  return GetAllCities(repository);
}

// CONTROLLERS
@riverpod
class Cities extends _$Cities {
  static const _cacheThreshold = Duration(hours: 1);

  @override
  Future<List<City>> build() async {
    final localCache = ref.watch(citiesLocalDatasourceProvider);
    final cachedCities = await localCache.getCachedCities();
    final lastUpdate = await localCache.getLastCacheTime();

    if (cachedCities.isNotEmpty) {
      final now = DateTime.now();
      final isStale =
          lastUpdate == null || now.difference(lastUpdate) > _cacheThreshold;

      if (isStale) {
        // Se os dados forem antigos, mostra o cache mas atualiza em background
        _updateFromRemote();
      }

      // Retorna o cache imediatamente (UI instantânea)
      return cachedCities;
    }

    // Se não houver cache nenhum, busca obrigatoriamente da API
    return _fetchRemote();
  }

  Future<List<City>> _fetchRemote() async {
    final getAllCities = ref.read(getAllCitiesProvider);
    final localCache = ref.watch(citiesLocalDatasourceProvider);

    final result = await getAllCities();
    return result.fold((failure) => throw Exception(failure.message), (
      cities,
    ) async {
      await localCache.cacheCities(cities);
      return cities;
    });
  }

  Future<void> _updateFromRemote() async {
    final getAllCities = ref.read(getAllCitiesProvider);
    final localCache = ref.watch(citiesLocalDatasourceProvider);

    final result = await getAllCities();

    result.fold(
      (failure) => logger.e('Background refresh error: ${failure.message}'),
      (cities) async {
        await localCache.cacheCities(cities);
        state = AsyncData(cities);
      },
    );
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetchRemote());
  }
}
