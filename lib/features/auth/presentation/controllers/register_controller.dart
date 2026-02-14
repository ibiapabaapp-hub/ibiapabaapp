import 'package:flutter/material.dart';
import 'package:ibiapabaapp/features/auth/domain/entities/register_form_data.dart';
import 'package:ibiapabaapp/features/auth/domain/usecases/check_unique_availability.dart';
import 'package:ibiapabaapp/features/auth/domain/usecases/register_with_email.dart';
import 'package:ibiapabaapp/features/auth/presentation/states/register_state.dart';

class RegisterController extends ChangeNotifier {
  final RegisterWithEmail registerWithEmail;
  final CheckUniqueAvailability checkAvailability;

  RegisterController(this.registerWithEmail, this.checkAvailability);

  RegisterState _state = RegisterInitial();
  RegisterState get state => _state;

  final RegisterFormData formData = RegisterFormData();

  final Map<String, ({bool? available, String? error})> _availability = {};

  bool? isAvailable(String field) => _availability[field]?.available;
  String? getError(String field) => _availability[field]?.error;

  void setName(String v) => formData.name = v;
  void setBirthDate(DateTime? v) => formData.birthDate = v;
  void setUsername(String v) => formData.username = v;
  void setPhone(String v) => formData.phoneNumber = v;
  void setEmail(String v) => formData.email = v;
  void setPassword(String v) => formData.password = v;
  void setConfirmPassword(String v) => formData.confirmPassword = v;

  Future<bool> _validateUnique(String field, String value) async {
    final result = await checkAvailability(field: field, value: value);

    return result.fold(
      (failure) {
        _availability[field] = (available: false, error: failure.message);
        notifyListeners();
        return false;
      },
      (availability) {
        _availability[field] = (available: availability.available, error: null);
        notifyListeners();
        return availability.available;
      },
    );
  }

  Future<bool> checkUsername(String v) => _validateUnique('username', v);
  Future<bool> checkEmail(String v) => _validateUnique('email', v);
  Future<bool> checkPhone(String v) => _validateUnique('phone_number', v);

  Future<void> submit() async {
    _state = RegisterLoading();
    notifyListeners();

    final result = await registerWithEmail(registerFormData: formData);

    _state = result.fold(
      (failure) => RegisterError(failure.message),
      (_) => RegisterSuccess(),
    );

    notifyListeners();
  }
}
