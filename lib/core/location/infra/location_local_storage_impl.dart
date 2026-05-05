import 'package:ibiapabaapp/core/cache/base_cache_storage.dart';
import 'package:ibiapabaapp/core/location/data/datasources/location_local_storage.dart';

class LocationLocalStorageImpl extends BaseCacheStorage
    implements LocationLocalStorage {
  LocationLocalStorageImpl(super.cacheDatabaseService);

  @override
  String get storeName => 'location';

  @override
  Future<void> saveCurrentCityId(String cityId) async {
    await saveObject(
      key: 'current_city_id',
      item: cityId,
      toMap: (i) => {'value': i},
    );
  }

  @override
  Future<void> clearCurrentCity() async {
    await clearKey('current_city_id');
  }

  @override
  Future<String?> getCurrentCityId() async {
    return getObject(key: 'current_city_id', fromJson: (json) => json['value']);
  }
}
