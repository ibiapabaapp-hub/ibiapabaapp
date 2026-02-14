import 'package:dartz/dartz.dart';
import 'package:ibiapabaapp/core/errors/failures/failures.dart';
import 'package:ibiapabaapp/features/auth/domain/entities/auth_result.dart';
import 'package:ibiapabaapp/features/auth/domain/entities/register_form_data.dart';
import 'package:ibiapabaapp/features/auth/domain/repositories/auth_repository.dart';

class RegisterWithEmail {
  final AuthRepository repository;

  RegisterWithEmail(this.repository);

  Future<Either<Failure, AuthResult>> call({
    required RegisterFormData registerFormData,
  }) {
    return repository.register(registerFormData: registerFormData);
  }
}
