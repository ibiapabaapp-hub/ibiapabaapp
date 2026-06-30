import 'package:mocktail/mocktail.dart';
import 'package:ibivibe/features/auth/auth_repository.dart';
import 'package:ibivibe/features/accounts/accounts_repository.dart';
import 'package:ibivibe/features/accounts/accounts_local_storage.dart';
import 'package:ibivibe/features/cities/cities_repository.dart';
import 'package:ibivibe/features/businesses/business_repository.dart';
import 'package:ibivibe/features/events/events_repository.dart';
import 'package:ibivibe/features/favorites/favorites_repository.dart';
import 'package:ibivibe/features/favorites/favorites_remote_datasource.dart';
import 'package:ibivibe/features/favorites/favorites_local_storage.dart';
import 'package:ibivibe/features/search/search_repository.dart';
import 'package:ibivibe/features/search/search_remote_datasource.dart';
import 'package:ibivibe/features/tags/tags_repository.dart';
import 'package:ibivibe/features/medias/medias_repository.dart';
import 'package:ibivibe/features/medias/medias_remote_datasource.dart';
import 'package:ibivibe/core/storage/token_storage_strategy.dart';
import 'package:ibivibe/core/cache/cache_database_service.dart';
import 'package:logger/logger.dart';
import 'package:dio/dio.dart';

class MockAuthRepository extends Mock implements AuthRepository {}
class MockAccountsRepository extends Mock implements AccountsRepository {}
class MockAccountsLocalStorage extends Mock implements AccountsLocalStorage {}
class MockCitiesRepository extends Mock implements CitiesRepository {}
class MockBusinessesRepository extends Mock implements BusinessesRepository {}
class MockEventsRepository extends Mock implements EventsRepository {}
class MockFavoritesRepository extends Mock implements FavoritesRepository {}
class MockFavoritesRemoteDatasource extends Mock implements FavoritesRemoteDatasource {}
class MockFavoritesLocalStorage extends Mock implements FavoritesLocalStorage {}
class MockSearchRepository extends Mock implements SearchRepository {}
class MockSearchRemoteDatasource extends Mock implements SearchRemoteDatasource {}
class MockTagsRepository extends Mock implements TagsRepository {}
class MockMediasRepository extends Mock implements MediasRepository {}
class MockMediasRemoteDatasource extends Mock implements MediasRemoteDatasource {}
class MockTokenStorageStrategy extends Mock implements TokenStorageStrategy {}
class MockCacheDatabaseService extends Mock implements CacheDatabaseService {}
class MockLogger extends Mock implements Logger {}
class MockDio extends Mock implements Dio {}
class MockResponse<T> extends Mock implements Response<T> {}
