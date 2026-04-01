import 'package:dartz/dartz.dart';
import 'package:ibiapabaapp/core/errors/failures/failures.dart';
import 'package:ibiapabaapp/features/auth/domain/entities/check_availability.dart';
import 'package:ibiapabaapp/features/auth/domain/entities/register_form_data.dart';
import 'package:ibiapabaapp/features/auth/domain/entities/auth_result.dart';
import 'package:ibiapabaapp/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<Either<AppFailure, CheckAvailability>> checkAvailability({
    required AvailabilityField field,
    required String value,
  });

  Future<Either<AppFailure, AuthResult>> login({
    required String email,
    required String password,
  });

  Future<Either<AppFailure, AuthResult>> register({
    required RegisterFormData registerFormData,
  });

  Future<Either<AppFailure, User>> getMe();

  Future<Either<AppFailure, AuthResult>> refreshTokens();
}
