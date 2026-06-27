import 'package:ibivibe/core/cache/cache_database_provider.dart';
import 'package:ibivibe/core/logger/logger.dart';
import 'package:ibivibe/core/network/dio_provider.dart';
import 'package:ibivibe/features/businesses/data/repositories/businesses_repository_impl.dart';
import 'package:ibivibe/features/businesses/domain/repositories/business_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'businesses_providers.g.dart';

@riverpod
BusinessesRepository businessesRepository(Ref ref) {
  final logger = ref.read(loggerProvider);
  final dio = ref.watch(dioProvider);
  final cacheService = ref.watch(cacheDatabaseServiceProvider);

  return BusinessesRepositoryImpl(
    dio: dio,
    cacheService: cacheService,
    logger: logger,
  );
}
