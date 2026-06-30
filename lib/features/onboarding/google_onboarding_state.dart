import 'package:ibivibe/shared/models/account_type.dart';
import 'package:ibivibe/shared/models/gender.dart';
import 'package:ibivibe/features/auth/models/check_availability.dart';

enum GoogleOnboardingStatus { initial, loading, success, error }

class GoogleOnboardingState {
  final GoogleOnboardingStatus status;
  final String? slug;
  final Gender? gender;
  final AccountType? accountType;
  final String? errorMessage;
  final Map<
    AvailabilityField,
    ({bool? available, String? error, bool isChecking})
  > availability;

  GoogleOnboardingState({
    this.status = GoogleOnboardingStatus.initial,
    this.slug,
    this.gender,
    this.accountType,
    this.errorMessage,
    Map<
      AvailabilityField,
      ({bool? available, String? error, bool isChecking})
    >? availability,
  }) : availability = availability ??
          {
            AvailabilityField.slug: (
              available: null,
              error: null,
              isChecking: false,
            ),
          };

  factory GoogleOnboardingState.initial() => GoogleOnboardingState();

  GoogleOnboardingState copyWith({
    GoogleOnboardingStatus? status,
    String? slug,
    Gender? gender,
    AccountType? accountType,
    String? errorMessage,
    Map<
      AvailabilityField,
      ({bool? available, String? error, bool isChecking})
    >? availability,
    bool clearError = false,
    bool clearAvailability = false,
  }) {
    return GoogleOnboardingState(
      status: status ?? this.status,
      slug: slug ?? this.slug,
      gender: gender ?? this.gender,
      accountType: accountType ?? this.accountType,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      availability: clearAvailability
          ? {
              AvailabilityField.slug: (
                available: null,
                error: null,
                isChecking: false,
              ),
            }
          : (availability ?? this.availability),
    );
  }
}
