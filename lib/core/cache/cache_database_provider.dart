import 'package:ibiapabaapp/core/cache/cache_database_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sembast/sembast.dart';

part 'cache_database_provider.g.dart';

@riverpod
Database cacheDatabase(Ref ref) {
  return CacheDatabaseService.db;
}
