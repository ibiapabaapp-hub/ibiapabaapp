// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'google_oauth_state_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(GoogleOAuthState)
final googleOAuthStateProvider = GoogleOAuthStateProvider._();

final class GoogleOAuthStateProvider
    extends $NotifierProvider<GoogleOAuthState, GoogleOAuthDataState> {
  GoogleOAuthStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'googleOAuthStateProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$googleOAuthStateHash();

  @$internal
  @override
  GoogleOAuthState create() => GoogleOAuthState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GoogleOAuthDataState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GoogleOAuthDataState>(value),
    );
  }
}

String _$googleOAuthStateHash() => r'318ed0bce40fb49c6a4b522c12a36fbcb8042894';

abstract class _$GoogleOAuthState extends $Notifier<GoogleOAuthDataState> {
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
