import 'package:ibivibe/features/auth/domain/entities/check_availability.dart';
import 'package:ibivibe/features/auth/domain/entities/register_form_data.dart';

enum RegisterStatus { initial, loading, success, error }

class RegisterState {
  final RegisterStatus status;
  final RegisterFormData formData;
  final Map<AvailabilityField, ({bool? available, String? error, bool isChecking})> availability;
  final String? errorMessage;

  RegisterState({
    required this.status,
    required this.formData,
    required this.availability,
    this.errorMessage,
  });

  factory RegisterState.initial() => RegisterState(
    status: RegisterStatus.initial,
    formData: RegisterFormData(),
    availability: {
      AvailabilityField.slug: (available: null, error: null, isChecking: false),
      AvailabilityField.email: (available: null, error: null, isChecking: false),
      AvailabilityField.phoneNumber: (available: null, error: null, isChecking: false),
    },
  );

  RegisterState copyWith({
    RegisterStatus? status,
    RegisterFormData? formData,
    Map<AvailabilityField, ({bool? available, String? error, bool isChecking})>? availability,
    String? errorMessage,
  }) {
    return RegisterState(
      status: status ?? this.status,
      formData: formData ?? this.formData,
      availability: availability ?? this.availability,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
