import 'package:dartz/dartz.dart';
import 'package:ibiapabaapp/core/errors/failures/failures.dart';
import 'package:ibiapabaapp/core/usecases/usecase_without_params.dart';
import 'package:ibiapabaapp/shared/models/account.dart';
import 'package:ibiapabaapp/features/accounts/domain/repositories/accounts_repository.dart';

class GetCachedAccounts implements UsecaseWithoutParams<List<Account>> {
  final AccountsRepository repository;

  GetCachedAccounts(this.repository);

  @override
  Future<Either<AppFailure, List<Account>>> call() {
    return repository.getCachedAccounts();
  }
}
