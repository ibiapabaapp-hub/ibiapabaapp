import 'package:ibiapabaapp/shared/models/business.dart';

abstract class BusinessesLocalDatasource {
  Future<List<Business>> getCachedBusinesses();
  Future<Business?> getBusinessById(String id);
  Future<void> cacheBusinesses(List<Business> businesses);
  Future<void> cacheBusiness(Business business);
  Future<void> clearCache();
}
