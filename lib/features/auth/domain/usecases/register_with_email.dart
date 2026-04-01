import 'package:dartz/dartz.dart';
import 'package:ibiapabaapp/core/errors/failures/failures.dart';
import 'package:ibiapabaapp/core/usecases/usecase.dart';
import 'package:ibiapabaapp/features/auth/domain/entities/auth_result.dart';
import 'package:ibiapabaapp/features/auth/domain/entities/register_form_data.dart';
import 'package:ibiapabaapp/features/auth/domain/repositories/auth_repository.dart';

class RegisterWithEmail
    implements Usecase<AuthResult, RegisterWithEmailParams> {
  final AuthRepository repository;

  RegisterWithEmail(this.repository);

  @override
  Future<Either<AppFailure, AuthResult>> call(RegisterWithEmailParams params) {
    return repository.register(registerFormData: params.registerFormData);
  }
}

class RegisterWithEmailParams {
  final RegisterFormData registerFormData;

  RegisterWithEmailParams({required this.registerFormData});
}
