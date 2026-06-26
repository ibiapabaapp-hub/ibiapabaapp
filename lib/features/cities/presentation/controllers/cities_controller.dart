import 'package:ibiapabaapp/core/logger/handlers/controller_log_handler.dart';
import 'package:ibiapabaapp/core/logger/log_tags.dart';
import 'package:ibiapabaapp/core/logger/logger.dart';
import 'package:ibiapabaapp/shared/providers/accounts_state_provider.dart';
import 'package:ibiapabaapp/shared/models/city.dart';
import 'package:ibiapabaapp/features/cities/domain/tags/cities_logtags.dart';
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
    ref.listen(accountsStateProvider, (previous, next) {
      final account = next.activeAccount;
      final previousAccount = previous?.activeAccount;
      if (account != null && previousAccount == null) {
        getAllCities();
      } else if (account == null) {
        state = const AsyncData([]);
      }
    });

    final user = ref.watch(accountsStateProvider).activeAccount;
    if (user == null) return [];
    return _fetchRemote();
  }

  Future<List<City>> _fetchRemote({bool forceRefresh = false}) async {
    final repository = ref.read(citiesRepositoryProvider);
    try {
      final cities = await repository.getAllCities(forceRefresh: forceRefresh);
      if (!ref.mounted) throw Exception('Provider disposed');
      logControllerSuccess(action: CityAction.getAllCities);
      return cities;
    } catch (e) {
      logControllerError(action: CityAction.getAllCities, failure: e);
      throw Exception(e.toString());
    }
  }

  Future<void> getAllCities({bool forceRefresh = false}) async {
    state = const AsyncLoading();
    final repository = ref.read(citiesRepositoryProvider);
    try {
      final cities = await repository.getAllCities(forceRefresh: forceRefresh);
      if (!ref.mounted) return;
      logControllerSuccess(action: CityAction.getAllCities);
      state = AsyncData(cities);
    } catch (e) {
      logControllerError(action: CityAction.getAllCities, failure: e);
      state = AsyncError(e.toString(), StackTrace.current);
    }
  }

  Future<void> getCityById(String id) async {
    if (state is! AsyncData<List<City>>) return;
    final currentCities = (state as AsyncData<List<City>>).value;

    state = const AsyncLoading();
    final repository = ref.read(citiesRepositoryProvider);
    try {
      final city = await repository.getCityById(id);
      if (!ref.mounted) return;
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
    } catch (e) {
      logControllerError(action: CityAction.getCityById, failure: e);
      state = AsyncError(e.toString(), StackTrace.current);
    }
  }

  Future<void> refresh() async {
    await getAllCities(forceRefresh: true);
  }
}
