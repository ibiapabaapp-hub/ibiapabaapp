// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'google_onboarding_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(GoogleOnboardingViewModel)
final googleOnboardingViewModelProvider = GoogleOnboardingViewModelProvider._();

final class GoogleOnboardingViewModelProvider
    extends
        $NotifierProvider<GoogleOnboardingViewModel, GoogleOnboardingState> {
  GoogleOnboardingViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'googleOnboardingViewModelProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$googleOnboardingViewModelHash();

  @$internal
  @override
  GoogleOnboardingViewModel create() => GoogleOnboardingViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GoogleOnboardingState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GoogleOnboardingState>(value),
    );
  }
}

String _$googleOnboardingViewModelHash() =>
    r'eac477ff60726f875eab809dcc461b78124aa71a';

abstract class _$GoogleOnboardingViewModel
    extends $Notifier<GoogleOnboardingState> {
  GoogleOnboardingState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<GoogleOnboardingState, GoogleOnboardingState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<GoogleOnboardingState, GoogleOnboardingState>,
              GoogleOnboardingState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
