import 'package:dio/dio.dart';
import 'package:ibivibe/features/cities/infra/models/cities_model.dart';
import 'package:ibivibe/features/businesses/infra/models/business_model.dart';
import 'package:ibivibe/features/events/infra/models/event_model.dart';
import 'package:ibivibe/features/search/data/datasources/search_remote_datasource.dart';
import 'package:ibivibe/features/search/infra/models/search_result_model.dart';

class SearchRemoteDataSourceImpl implements SearchRemoteDatasource {
  final Dio dio;

  SearchRemoteDataSourceImpl(this.dio);

  @override
  Future<List<SearchResultModel>> search(String query) async {
    final response = await dio.get('/search', queryParameters: {'q': query});

    final data = response.data;
    if (data is Map<String, dynamic>) {
      final results = <SearchResultModel>[];

      if (data.containsKey('cities') && data['cities'] is List) {
        results.addAll(
          (data['cities'] as List).map(
            (json) => SearchResultModel.city(CityModel.fromJson(json)),
          ),
        );
      }

      if (data.containsKey('businesses') && data['businesses'] is List) {
        results.addAll(
          (data['businesses'] as List).map(
            (json) => SearchResultModel.business(BusinessModel.fromJson(json)),
          ),
        );
      }

      if (data.containsKey('events') && data['events'] is List) {
        results.addAll(
          (data['events'] as List).map(
            (json) => SearchResultModel.event(EventModel.fromJson(json)),
          ),
        );
      }

      return results;
    }

    return [];
  }
}
