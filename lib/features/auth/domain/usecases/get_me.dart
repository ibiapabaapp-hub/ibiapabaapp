import 'package:dartz/dartz.dart';
import 'package:ibiapabaapp/core/errors/failures/failures.dart';
import 'package:ibiapabaapp/core/usecases/usecase_without_params.dart';
import 'package:ibiapabaapp/features/auth/domain/entities/user.dart';
import 'package:ibiapabaapp/features/auth/domain/repositories/auth_repository.dart';

class GetMe implements UsecaseWithoutParams<User> {
  final AuthRepository repository;

  GetMe(this.repository);

  @override
  Future<Either<AppFailure, User>> call() {
    return repository.getMe();
  }
}
