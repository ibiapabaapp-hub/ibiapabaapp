import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ibivibe/features/cities/infra/models/cities_model.dart';
import 'package:ibivibe/features/businesses/infra/models/business_model.dart';
import 'package:ibivibe/features/events/infra/models/event_model.dart';
import 'package:ibivibe/features/search/domain/entities/search_result.dart';

part 'search_result_model.freezed.dart';

@freezed
sealed class SearchResultModel with _$SearchResultModel {
  const SearchResultModel._();

  const factory SearchResultModel.city(CityModel city) = _CitySearchResultModel;
  const factory SearchResultModel.business(BusinessModel business) =
      _BusinessSearchResultModel;
  const factory SearchResultModel.event(EventModel event) =
      _EventSearchResultModel;

  factory SearchResultModel.fromJson(Map<String, dynamic> json) {
    final type = json['type'] as String?;
    switch (type) {
      case 'city':
        return SearchResultModel.city(CityModel.fromJson(json));
      case 'business':
        return SearchResultModel.business(BusinessModel.fromJson(json));
      case 'event':
        return SearchResultModel.event(EventModel.fromJson(json));
      default:
        if (json.containsKey('cityId')) {
          return SearchResultModel.city(CityModel.fromJson(json));
        }

        throw CheckedFromJsonException(
          json,
          'type',
          'SearchResultModel',
          'Unknown type: $type',
        );
    }
  }

  SearchResult toEntity() {
    return when(
      city: (city) => CitySearchResult(city),
      business: (business) => BusinessSearchResult(business),
      event: (event) => EventSearchResult(event),
    );
  }
}
