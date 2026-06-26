import 'package:ibiapabaapp/features/auth/domain/entities/auth_result.dart';
import 'package:ibiapabaapp/features/auth/domain/entities/check_availability.dart';
import 'package:ibiapabaapp/features/auth/domain/entities/complete_google_registration.dart';
import 'package:ibiapabaapp/features/auth/domain/entities/google_auth_result.dart';
import 'package:ibiapabaapp/features/auth/domain/entities/register_form_data.dart';
import 'package:ibiapabaapp/shared/models/account.dart';

abstract class AuthRemoteDatasource {
  Future<AuthResult> login({required String email, required String password});

  Future<AuthResult> register({required RegisterFormData registerFormData});

  Future<CheckAvailability> checkAvailability({
    required String field,
    required String value,
  });

  Future<Account> getMe();

  Future<AuthResult> refreshTokens();

  Future<GoogleAuthResult> loginWithGoogle({required String idToken});

  Future<CompleteGoogleRegistrationResponse> completeGoogleRegistration({
    required String tempToken,
    required String slug,
    required String type,
    String? gender,
  });
}
