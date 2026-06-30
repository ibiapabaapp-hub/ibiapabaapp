// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'google_oauth_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(GoogleOAuthViewModel)
final googleOAuthViewModelProvider = GoogleOAuthViewModelProvider._();

final class GoogleOAuthViewModelProvider
    extends $NotifierProvider<GoogleOAuthViewModel, GoogleOAuthDataState> {
  GoogleOAuthViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'googleOAuthViewModelProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$googleOAuthViewModelHash();

  @$internal
  @override
  GoogleOAuthViewModel create() => GoogleOAuthViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GoogleOAuthDataState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GoogleOAuthDataState>(value),
    );
  }
}

String _$googleOAuthViewModelHash() =>
    r'6d1e1e86436c16914ea2038b63d5fff4133d9932';

abstract class _$GoogleOAuthViewModel extends $Notifier<GoogleOAuthDataState> {
  GoogleOAuthDataState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<GoogleOAuthDataState, GoogleOAuthDataState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<GoogleOAuthDataState, GoogleOAuthDataState>,
              GoogleOAuthDataState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
