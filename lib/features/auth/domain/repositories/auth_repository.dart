import 'package:dartz/dartz.dart';
import 'package:ibiapabaapp/core/errors/failures/failures.dart';
import 'package:ibiapabaapp/features/auth/domain/entities/check_availability.dart';
import 'package:ibiapabaapp/features/auth/domain/entities/register_form_data.dart';
import 'package:ibiapabaapp/features/auth/domain/entities/auth_result.dart';

abstract class AuthRepository {
  Future<Either<Failure, CheckAvailability>> checkAvailability({
    required String field,
    required String value,
  });

  Future<Either<Failure, AuthResult>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, AuthResult>> register({
    required RegisterFormData registerFormData,
  });
}
