import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ibiapabaapp/core/logger/handlers/controller_log_handler.dart';
import 'package:ibiapabaapp/core/logger/log_tags.dart';
import 'package:ibiapabaapp/core/logger/logger.dart';
import 'package:ibiapabaapp/core/session/app_session_notifier_provider.dart';
import 'package:ibiapabaapp/features/cities/domain/entities/city.dart';
import 'package:ibiapabaapp/features/cities/domain/tags/cities_logtags.dart';
import 'package:ibiapabaapp/features/cities/domain/usecases/get_all_cities.dart';
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

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetchRemote(forceRefresh: true));
  }
}
