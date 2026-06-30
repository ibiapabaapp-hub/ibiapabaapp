import 'package:ibivibe/features/search/models/search_result.dart';

abstract class SearchRepository {
  Future<List<SearchResult>> search(String query);
}
