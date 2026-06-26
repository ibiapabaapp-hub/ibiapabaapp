import 'package:ibiapabaapp/features/search/domain/entities/search_result.dart';

abstract class SearchRepository {
  Future<List<SearchResult>> search(String query);
}
