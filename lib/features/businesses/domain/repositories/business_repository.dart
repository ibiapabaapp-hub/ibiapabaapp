import 'package:dartz/dartz.dart';
import 'package:ibiapabaapp/core/errors/failures/failures.dart';
import 'package:ibiapabaapp/shared/models/business.dart';

abstract class BusinessesRepository {
  Future<Either<AppFailure, List<Business>>> getAllBusinesses();
  Future<Either<AppFailure, Business?>> getBusinessById(String id);
}
