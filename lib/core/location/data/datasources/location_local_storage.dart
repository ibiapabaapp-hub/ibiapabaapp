abstract class LocationLocalStorage {
  Future<void> saveCurrentCityId(String cityId);
  Future<void> clearCurrentCity();
  Future<String?> getCurrentCityId();
}
