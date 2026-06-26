import 'package:dio/dio.dart';
import 'package:ibiapabaapp/core/cache/cache_database_service.dart';
import 'package:ibiapabaapp/core/logger/handlers/repository_log_handler.dart';
import 'package:ibiapabaapp/core/logger/log_tags.dart';
import 'package:ibiapabaapp/shared/models/business.dart';
import 'package:ibiapabaapp/features/businesses/domain/repositories/business_repository.dart';
import 'package:ibiapabaapp/features/businesses/infra/models/business_model.dart';
import 'package:logger/logger.dart';

class BusinessesRepositoryImpl
    with RepositoryLogHandler
    implements BusinessesRepository {
  @override
  final Logger logger;
  final Dio dio;
  final CacheDatabaseService cacheService;

  static const _storeName = 'businesses_cache';
  static const _allBusinessesKey = 'all_businesses';
  static const _maxAge = Duration(days: 7);

  BusinessesRepositoryImpl({
    required this.logger,
    required this.dio,
    required this.cacheService,
  });

  @override
  LogFeature get feature => LogFeature.businesses;

  @override
  Future<List<Business>> getAllBusinesses() async {
    final cached = await cacheService.getList<Business>(
      storeName: _storeName,
      key: _allBusinessesKey,
      fromJson: BusinessModel.fromJson,
      maxAge: _maxAge,
    );
    if (cached.isNotEmpty) return cached;

    final response = await dio.get('/businesses');
    final result = BusinessModel.fromJsonList(response.data);
    await cacheService.saveList<Business>(
      storeName: _storeName,
      key: _allBusinessesKey,
      items: result,
      toMap: BusinessModel.toMap,
    );
    return result;
  }

  @override
  Future<Business?> getBusinessById(String id) async {
    final individual = await cacheService.getObject<Business>(
      storeName: _storeName,
      key: 'business_$id',
      fromJson: (json) => BusinessModel.fromJson(json),
      maxAge: _maxAge,
    );
    if (individual != null) return individual;

    final cached = await cacheService.getList<Business>(
      storeName: _storeName,
      key: _allBusinessesKey,
      fromJson: BusinessModel.fromJson,
      maxAge: _maxAge,
    );
    final fromList = cached.cast<Business?>().firstWhere(
          (b) => b?.id == id,
          orElse: () => null,
        );
    if (fromList != null) return fromList;

    final response = await dio.get('/businesses/$id');
    final result = BusinessModel.fromJson(response.data);
    await cacheService.saveObject<Business>(
      storeName: _storeName,
      key: 'business_$id',
      item: result,
      toMap: BusinessModel.toMap,
    );
    return result;
  }
}
