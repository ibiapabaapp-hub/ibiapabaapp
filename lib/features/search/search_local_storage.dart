abstract class SearchLocalStorage {
  Future<void> saveRecentSearches(List<String> searches);
  Future<List<String>> getRecentSearches();
}
