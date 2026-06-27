import 'package:ibivibe/shared/models/business.dart';

abstract class BusinessesRepository {
  Future<List<Business>> getAllBusinesses();
  Future<Business?> getBusinessById(String id);
}
