import 'package:ibiapabaapp/core/cache/cache_database_service.dart';
import 'package:ibiapabaapp/features/businesses/data/datasource/businesses_local_datasource.dart';
import 'package:ibiapabaapp/shared/models/business.dart';
import 'package:ibiapabaapp/features/businesses/infra/models/business_model.dart';

class BusinessesLocalDatasourceImpl implements BusinessesLocalDatasource {
  final CacheDatabaseService cacheService;
  static const _storeName = 'businesses_cache';
  static const _allBusinessesKey = 'all_businesses';

  // Cache expires after 7 days
  static const _maxAge = Duration(days: 7);

  BusinessesLocalDatasourceImpl({required this.cacheService});

  @override
  Future<List<Business>> getCachedBusinesses() async {
    return cacheService.getList<Business>(
      storeName: _storeName,
      key: _allBusinessesKey,
      fromJson: (json) => BusinessModel.fromJson(json),
      maxAge: _maxAge,
    );
  }

  @override
  Future<Business?> getBusinessById(String id) async {
    // Try to get from specific object cache first
    final individual = await cacheService.getObject<Business>(
      storeName: _storeName,
      key: 'business_$id',
      fromJson: (json) => BusinessModel.fromJson(json),
      maxAge: _maxAge,
    );

    if (individual != null) return individual;

    // Fallback: search in the full list cache
    final businesses = await getCachedBusinesses();
    try {
      return businesses.firstWhere((c) => c.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> cacheBusinesses(List<Business> businesses) async {
    await cacheService.saveList<Business>(
      storeName: _storeName,
      key: _allBusinessesKey,
      items: businesses,
      toMap: (c) => BusinessModel.toMap(c),
    );
  }

  @override
  Future<void> cacheBusiness(Business business) async {
    await cacheService.saveObject<Business>(
      storeName: _storeName,
      key: 'business_${business.id}',
      item: business,
      toMap: (c) => BusinessModel.toMap(c),
    );
  }

  @override
  Future<void> clearCache() async {
    await cacheService.clear(storeName: _storeName);
  }
}
