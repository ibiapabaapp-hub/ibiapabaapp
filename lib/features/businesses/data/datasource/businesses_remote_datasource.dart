import 'package:ibiapabaapp/shared/models/business.dart';

abstract class BusinessesRemoteDatasource {
  Future<List<Business>> getAllBusinesses();
  Future<Business> getBusinessById(String id);
}
