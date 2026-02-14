import 'package:dartz/dartz.dart';
import 'package:ibiapabaapp/core/errors/failures/failures.dart';
import 'package:ibiapabaapp/features/auth/domain/entities/auth_result.dart';
import 'package:ibiapabaapp/features/auth/domain/repositories/auth_repository.dart';

class LoginWithEmail {
  final AuthRepository repository;

  LoginWithEmail(this.repository);

  Future<Either<Failure, AuthResult>> call(String email, String password) {
    return repository.login(email: email, password: password);
  }
}
