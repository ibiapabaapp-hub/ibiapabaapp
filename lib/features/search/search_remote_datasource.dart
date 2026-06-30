import 'package:ibivibe/features/search/models/search_result_model.dart';

abstract class SearchRemoteDatasource {
  Future<List<SearchResultModel>> search(String query);
}