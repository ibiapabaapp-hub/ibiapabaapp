import 'package:dartz/dartz.dart';
import 'package:ibiapabaapp/core/errors/failures/failures.dart';
import 'package:ibiapabaapp/features/auth/domain/entities/auth_result.dart';
import 'package:ibiapabaapp/features/auth/domain/entities/check_availability.dart';
import 'package:ibiapabaapp/features/auth/domain/entities/complete_google_registration.dart';
import 'package:ibiapabaapp/features/auth/domain/entities/google_auth_result.dart';
import 'package:ibiapabaapp/features/auth/domain/entities/register_form_data.dart';
import 'package:ibiapabaapp/shared/models/account.dart';
import 'package:ibiapabaapp/shared/models/account_type.dart';
import 'package:ibiapabaapp/shared/models/gender.dart';

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

  Future<Either<AppFailure, Account>> getMe();

  Future<Either<AppFailure, AuthResult>> refreshTokens();

  Future<Either<AppFailure, GoogleAuthResult>> loginWithGoogle({
    required String idToken,
  });

  Future<Either<AppFailure, CompleteGoogleRegistrationResponse>>
  completeGoogleRegistration({
    required String tempToken,
    required String slug,
    required AccountType type,
    Gender? gender,
  });
}
