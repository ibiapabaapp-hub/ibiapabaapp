import 'package:ibivibe/core/errors/failures/failures.dart';
import 'package:ibivibe/features/auth/models/google_auth_result.dart';

class GoogleOAuthDataState {
  final bool isLoading;
  final String? tempToken;
  final GoogleAuthResult? googleAuthResult;
  final AppFailure? failure;
  final bool? slugAvailable;
  final bool slugChecking;
  final bool? emailAvailable;
  final bool emailChecking;
  // final bool? phoneAvailable;
  // final bool phoneChecking;

  const GoogleOAuthDataState({
    this.isLoading = false,
    this.tempToken,
    this.googleAuthResult,
    this.failure,
    this.slugAvailable,
    this.slugChecking = false,
    this.emailAvailable,
    this.emailChecking = false,
    // this.phoneAvailable,
    // this.phoneChecking = false,
  });

  GoogleOAuthDataState copyWith({
    bool? isLoading,
    String? tempToken,
    GoogleAuthResult? googleAuthResult,
    AppFailure? failure,
    bool clearTempToken = false,
    bool clearGoogleAuthResult = false,
    bool clearFailure = false,
    bool? slugAvailable,
    bool? slugChecking,
    bool clearSlugStatus = false,
    bool? emailAvailable,
    bool? emailChecking,
    bool clearEmailStatus = false,
    // bool? phoneAvailable,
    // bool? phoneChecking,
    // bool clearPhoneStatus = false,
  }) {
    return GoogleOAuthDataState(
      isLoading: isLoading ?? this.isLoading,
      tempToken: clearTempToken ? null : (tempToken ?? this.tempToken),
      googleAuthResult: clearGoogleAuthResult
          ? null
          : (googleAuthResult ?? this.googleAuthResult),
      failure: clearFailure ? null : (failure ?? this.failure),
      slugAvailable: clearSlugStatus
          ? null
          : (slugAvailable ?? this.slugAvailable),
      slugChecking: slugChecking ?? this.slugChecking,
      emailAvailable: clearEmailStatus
          ? null
          : (emailAvailable ?? this.emailAvailable),
      emailChecking: emailChecking ?? this.emailChecking,
      // phoneAvailable: clearPhoneStatus
      //     ? null
      //     : (phoneAvailable ?? this.phoneAvailable),
      // phoneChecking: phoneChecking ?? this.phoneChecking,
    );
  }
}
