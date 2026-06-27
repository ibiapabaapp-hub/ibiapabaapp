import 'package:mocktail/mocktail.dart';
import 'package:ibiapabaapp/features/auth/domain/repositories/auth_repository.dart';
import 'package:ibiapabaapp/features/accounts/domain/repositories/accounts_repository.dart';
import 'package:ibiapabaapp/features/accounts/data/datasources/accounts_local_storage.dart';
import 'package:ibiapabaapp/features/cities/domain/repositories/cities_repository.dart';
import 'package:ibiapabaapp/features/businesses/domain/repositories/business_repository.dart';
import 'package:ibiapabaapp/features/events/domain/repositories/events_repository.dart';
import 'package:ibiapabaapp/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:ibiapabaapp/features/favorites/data/datasources/favorites_remote_datasource.dart';
import 'package:ibiapabaapp/features/favorites/data/datasources/favorites_local_storage.dart';
import 'package:ibiapabaapp/features/search/domain/repositories/search_repository.dart';
import 'package:ibiapabaapp/features/search/data/datasources/search_remote_datasource.dart';
import 'package:ibiapabaapp/features/categories/domain/repositories/categories_repository.dart';
import 'package:ibiapabaapp/features/medias/domain/repositories/medias_repository.dart';
import 'package:ibiapabaapp/features/medias/data/datasource/medias_remote_datasource.dart';
import 'package:ibiapabaapp/core/storage/token_storage_strategy.dart';
import 'package:ibiapabaapp/core/cache/cache_database_service.dart';
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
class MockCategoriesRepository extends Mock implements CategoriesRepository {}
class MockMediasRepository extends Mock implements MediasRepository {}
class MockMediasRemoteDatasource extends Mock implements MediasRemoteDatasource {}
class MockTokenStorageStrategy extends Mock implements TokenStorageStrategy {}
class MockCacheDatabaseService extends Mock implements CacheDatabaseService {}
class MockLogger extends Mock implements Logger {}
class MockDio extends Mock implements Dio {}
class MockResponse<T> extends Mock implements Response<T> {}
