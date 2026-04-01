import 'package:dartz/dartz.dart';
import 'package:ibiapabaapp/core/errors/failures/failures.dart';
import 'package:ibiapabaapp/core/usecases/usecase_without_params.dart';
import 'package:ibiapabaapp/features/auth/domain/entities/auth_result.dart';
import 'package:ibiapabaapp/features/auth/domain/repositories/auth_repository.dart';

class RefreshTokens implements UsecaseWithoutParams<AuthResult> {
  final AuthRepository repository;

  RefreshTokens(this.repository);

  @override
  Future<Either<AppFailure, AuthResult>> call() {
    return repository.refreshTokens();
  }
}
