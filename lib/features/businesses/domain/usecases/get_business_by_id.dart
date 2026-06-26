import 'package:dartz/dartz.dart';
import 'package:ibiapabaapp/core/errors/failures/failures.dart';
import 'package:ibiapabaapp/shared/models/business.dart';
import 'package:ibiapabaapp/features/businesses/domain/repositories/business_repository.dart';

class GetBusinessById {
  final BusinessesRepository repository;
  GetBusinessById(this.repository);

  Future<Either<AppFailure, Business?>> call(String id) {
    return repository.getBusinessById(id);
  }
}
