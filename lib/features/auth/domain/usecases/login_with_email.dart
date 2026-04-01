import 'package:dartz/dartz.dart';
import 'package:ibiapabaapp/core/errors/failures/failures.dart';
import 'package:ibiapabaapp/core/usecases/usecase.dart';
import 'package:ibiapabaapp/features/auth/domain/entities/auth_result.dart';
import 'package:ibiapabaapp/features/auth/domain/repositories/auth_repository.dart';

class LoginWithEmail implements Usecase<AuthResult, LoginWithEmailParams> {
  final AuthRepository repository;

  LoginWithEmail(this.repository);

  @override
  Future<Either<AppFailure, AuthResult>> call(LoginWithEmailParams params) {
    return repository.login(email: params.email, password: params.password);
  }
}

class LoginWithEmailParams {
  final String email;
  final String password;

  const LoginWithEmailParams({required this.email, required this.password});
}
