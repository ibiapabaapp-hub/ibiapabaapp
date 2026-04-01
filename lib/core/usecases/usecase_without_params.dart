import 'package:dartz/dartz.dart';
import 'package:ibiapabaapp/core/errors/failures/failures.dart';

abstract class UsecaseWithoutParams<SuccessType> {
  Future<Either<AppFailure, SuccessType>> call();
}
