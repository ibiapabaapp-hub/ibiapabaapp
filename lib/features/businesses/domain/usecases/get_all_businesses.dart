import 'package:dartz/dartz.dart';
import 'package:ibiapabaapp/core/errors/failures/failures.dart';
import 'package:ibiapabaapp/shared/models/business.dart';
import 'package:ibiapabaapp/features/businesses/domain/repositories/business_repository.dart';

class GetAllBusinesses {
  final BusinessesRepository repository;

  GetAllBusinesses(this.repository);

  Future<Either<AppFailure, List<Business>>> call() {
    return repository.getAllBusinesses();
  }
}
