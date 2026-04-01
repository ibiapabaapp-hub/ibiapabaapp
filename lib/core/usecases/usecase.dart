import 'package:dartz/dartz.dart';
import 'package:ibiapabaapp/core/errors/failures/failures.dart';

abstract interface class Usecase<SuccessType, Params> {
  Future<Either<AppFailure, SuccessType>> call(Params params);
}
