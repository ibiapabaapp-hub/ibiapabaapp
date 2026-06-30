import 'package:ibivibe/shared/models/city.dart';
import 'package:ibivibe/shared/models/business.dart';
import 'package:ibivibe/shared/models/event.dart';

sealed class SearchResult {
  const SearchResult();
}

class CitySearchResult extends SearchResult {
  final City city;
  const CitySearchResult(this.city);
}

class BusinessSearchResult extends SearchResult {
  final Business business;
  const BusinessSearchResult(this.business);
}

class EventSearchResult extends SearchResult {
  final Event event;
  const EventSearchResult(this.event);
}
