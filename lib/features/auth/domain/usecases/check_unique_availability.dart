import 'package:dartz/dartz.dart';
import 'package:ibiapabaapp/core/errors/failures/failures.dart';
import 'package:ibiapabaapp/features/auth/domain/repositories/auth_repository.dart';
import 'package:ibiapabaapp/features/auth/domain/entities/check_availability.dart';

class CheckUniqueAvailability {
  final AuthRepository repository;

  CheckUniqueAvailability(this.repository);

  Future<Either<Failure, CheckAvailability>> call({
    required String field,
    required String value,
  }) {
    return repository.checkAvailability(field: field, value: value);
  }
}
