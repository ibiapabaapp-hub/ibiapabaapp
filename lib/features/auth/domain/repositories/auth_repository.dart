import 'package:ibivibe/features/auth/domain/entities/auth_result.dart';
import 'package:ibivibe/features/auth/domain/entities/check_availability.dart';
import 'package:ibivibe/features/auth/domain/entities/complete_google_registration.dart';
import 'package:ibivibe/features/auth/domain/entities/google_auth_result.dart';
import 'package:ibivibe/features/auth/domain/entities/register_form_data.dart';
import 'package:ibivibe/shared/models/account.dart';
import 'package:ibivibe/shared/models/account_type.dart';
import 'package:ibivibe/shared/models/gender.dart';

abstract class AuthRepository {
  Future<CheckAvailability> checkAvailability({
    required AvailabilityField field,
    required String value,
  });

  Future<AuthResult> login({
    required String email,
    required String password,
  });

  Future<AuthResult> register({
    required RegisterFormData registerFormData,
  });

  Future<Account> getMe();

  Future<AuthResult> refreshTokens();

  Future<GoogleAuthResult> loginWithGoogle({
    required String idToken,
  });

  Future<CompleteGoogleRegistrationResponse>
  completeGoogleRegistration({
    required String tempToken,
    required String slug,
    required AccountType type,
    Gender? gender,
  });
}
