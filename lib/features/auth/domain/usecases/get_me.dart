import 'package:dartz/dartz.dart';
import 'package:ibiapabaapp/core/errors/failures/failures.dart';
import 'package:ibiapabaapp/core/usecases/usecase_without_params.dart';
import 'package:ibiapabaapp/shared/models/account.dart';
import 'package:ibiapabaapp/features/auth/domain/repositories/auth_repository.dart';

class GetMe implements UsecaseWithoutParams<Account> {
  final AuthRepository repository;

  GetMe(this.repository);

  @override
  Future<Either<AppFailure, Account>> call() {
    return repository.getMe();
  }
}
