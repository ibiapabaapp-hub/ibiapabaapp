import 'package:sembast/sembast.dart';
import '../../domain/entities/city.dart';
import '../parsers/city_parser.dart';

abstract class CitiesLocalDatasource {
  Future<List<City>> getCachedCities();
  Future<void> cacheCities(List<City> cities);
  Future<DateTime?> getLastCacheTime(); // Novo método
}

class CitiesLocalDatasourceImpl implements CitiesLocalDatasource {
  final Database cacheDatabase;
  final _citiesStore = intMapStoreFactory.store('cities_store');
  final _metaStore = stringMapStoreFactory.store('metadata_store');

  CitiesLocalDatasourceImpl({required this.cacheDatabase});

  @override
  Future<List<City>> getCachedCities() async {
    final records = await _citiesStore.find(cacheDatabase);
    return records
        .map((snapshot) => CityParser.fromJson(snapshot.value))
        .toList();
  }

  @override
  Future<void> cacheCities(List<City> cities) async {
    await cacheDatabase.transaction((txn) async {
      await _citiesStore.delete(txn);

      final maps = cities.map((city) => CityParser.toMap(city)).toList();
      await _citiesStore.addAll(txn, maps);

      await _metaStore.record('last_update').put(txn, {
        'timestamp': DateTime.now().toIso8601String(),
      });
    });
  }

  @override
  Future<DateTime?> getLastCacheTime() async {
    final record = await _metaStore.record('last_update').get(cacheDatabase);
    if (record == null) return null;
    return DateTime.tryParse(record['timestamp'] as String);
  }
}
