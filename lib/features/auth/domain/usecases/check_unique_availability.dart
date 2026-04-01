import 'package:dartz/dartz.dart';
import 'package:ibiapabaapp/core/errors/failures/failures.dart';
import 'package:ibiapabaapp/core/usecases/usecase.dart';
import 'package:ibiapabaapp/features/auth/domain/repositories/auth_repository.dart';
import 'package:ibiapabaapp/features/auth/domain/entities/check_availability.dart';

class CheckUniqueAvailability
    implements Usecase<CheckAvailability, CheckUniqueAvailabilityParams> {
  final AuthRepository repository;

  CheckUniqueAvailability(this.repository);

  @override
  Future<Either<AppFailure, CheckAvailability>> call(
    CheckUniqueAvailabilityParams params,
  ) {
    return repository.checkAvailability(
      field: params.field,
      value: params.value,
    );
  }
}

class CheckUniqueAvailabilityParams {
  final AvailabilityField field;
  final String value;

  CheckUniqueAvailabilityParams({required this.field, required this.value});
}
