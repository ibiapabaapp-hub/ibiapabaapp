import 'package:ibivibe/core/logger/log_tags.dart';

enum OnboardingAction implements LogTag {
  updateInterests('[UPDATE_PROFILE_INTERESTS]'),
  submitInterests('[SUBMIT_PROFILE_INTERESTS]'),
  getCities('[GET_ONBOARDING_CITIES]'),
  submitBusinessData('[SUBMIT_BUSINESS_DATA]');

  @override
  final String tag;
  const OnboardingAction(this.tag);
}
