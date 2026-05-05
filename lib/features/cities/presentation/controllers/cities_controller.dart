import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ibiapabaapp/core/logger/handlers/controller_log_handler.dart';
import 'package:ibiapabaapp/core/logger/log_tags.dart';
import 'package:ibiapabaapp/core/logger/logger.dart';
import 'package:ibiapabaapp/core/session/app_session_notifier_provider.dart';
import 'package:ibiapabaapp/features/cities/domain/entities/city.dart';
import 'package:ibiapabaapp/features/cities/domain/tags/cities_logtags.dart';
import 'package:ibiapabaapp/features/cities/domain/usecases/get_all_cities.dart';
import 'package:ibiapabaapp/features/cities/domain/usecases/get_city_by_id.dart';
import 'package:ibiapabaapp/features/cities/presentation/providers/cities_providers.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cities_controller.g.dart';

@riverpod
class Cities extends _$Cities with ControllerLogHandler {
  @override
  late final Logger logger = ref.read(loggerProvider);

  @override
  LogFeature get feature => LogFeature.cities;

  @override
  Future<List<City>> build() async {
    ref.listen(appSessionProvider, (previous, next) {
      final account = next.account;
      final previousAccount = previous?.account;
      if (account != null && previousAccount == null) {
        getAllCities();
      } else if (account == null) {
        state = const AsyncData([]);
      }
    });

    final user = ref.watch(appSessionProvider.select((s) => s.account));
    if (user == null) return [];
    return _fetchRemote();
  }

  Future<List<City>> _fetchRemote({bool forceRefresh = false}) async {
    final getAllCitiesUsecase = ref.read(getAllCitiesProvider);
    final localCache = ref.read(citiesLocalDatasourceProvider);

    final result = await getAllCitiesUsecase(
      GetAllCitiesParams(forceRefresh: forceRefresh),
    );

    if (!ref.mounted) throw Exception('Provider disposed');

    return result.fold(
      (failure) {
        logControllerError(action: CityAction.getAllCities, failure: failure);
        throw Exception(failure.message);
      },
      (cities) async {
        logControllerSuccess(action: CityAction.getAllCities);
        await localCache.cacheCities(cities);
        return cities;
      },
    );
  }

  Future<void> getAllCities({bool forceRefresh = false}) async {
    state = const AsyncLoading();
    final usecase = ref.read(getAllCitiesProvider);
    final localCache = ref.read(citiesLocalDatasourceProvider);

    final result = await usecase(
      GetAllCitiesParams(forceRefresh: forceRefresh),
    );

    if (!ref.mounted) return;

    result.fold(
      (failure) {
        logControllerError(action: CityAction.getAllCities, failure: failure);
        state = AsyncError(failure.message, StackTrace.current);
      },
      (cities) async {
        logControllerSuccess(action: CityAction.getAllCities);
        await localCache.cacheCities(cities);
        state = AsyncData(cities);
      },
    );
  }

  Future<void> getCityById(String id) async {
    if (state is! AsyncData<List<City>>) return;
    final currentCities = (state as AsyncData<List<City>>).value;

    state = const AsyncLoading();
    final usecase = ref.read(getCityByIdProvider);
    final result = await usecase(GetCityByIdParams(id: id));

    if (!ref.mounted) return;

    result.fold(
      (failure) {
        logControllerError(action: CityAction.getCityById, failure: failure);
        state = AsyncError(failure.message, StackTrace.current);
      },
      (city) {
        logControllerSuccess(action: CityAction.getCityById);
        if (city != null) {
          final updated = [...currentCities];
          final index = updated.indexWhere((c) => c.id == city.id);
          if (index >= 0) {
            updated[index] = city;
          } else {
            updated.add(city);
          }
          state = AsyncData(updated);
        } else {
          state = AsyncData(currentCities);
        }
      },
    );
  }

  Future<void> refresh() async {
    await getAllCities(forceRefresh: true);
  }
}
