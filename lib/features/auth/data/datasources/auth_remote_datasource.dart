import 'package:ibiapabaapp/features/auth/domain/entities/auth_result.dart';
import 'package:ibiapabaapp/features/auth/domain/entities/check_availability.dart';
import 'package:ibiapabaapp/features/auth/domain/entities/register_form_data.dart';
import 'package:ibiapabaapp/features/auth/domain/entities/user.dart';

abstract class AuthRemoteDatasource {
  Future<AuthResult> login({required String email, required String password});

  Future<AuthResult> register({required RegisterFormData registerFormData});

  Future<CheckAvailability> checkAvailability({
    required String field,
    required String value,
  });

  Future<User> getMe();

  Future<AuthResult> refreshTokens();
}
