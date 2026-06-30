// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AuthViewModel)
final authViewModelProvider = AuthViewModelProvider._();

final class AuthViewModelProvider
    extends $NotifierProvider<AuthViewModel, AuthData> {
  AuthViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authViewModelProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authViewModelHash();

  @$internal
  @override
  AuthViewModel create() => AuthViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthData value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthData>(value),
    );
  }
}

String _$authViewModelHash() => r'31240248e4c304ecda2b410e413661fd1999e9f5';

abstract class _$AuthViewModel extends $Notifier<AuthData> {
  AuthData build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AuthData, AuthData>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AuthData, AuthData>,
              AuthData,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(currentAuthStatus)
final currentAuthStatusProvider = CurrentAuthStatusProvider._();

final class CurrentAuthStatusProvider
    extends $FunctionalProvider<AuthStatus, AuthStatus, AuthStatus>
    with $Provider<AuthStatus> {
  CurrentAuthStatusProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentAuthStatusProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentAuthStatusHash();

  @$internal
  @override
  $ProviderElement<AuthStatus> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AuthStatus create(Ref ref) {
    return currentAuthStatus(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthStatus value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthStatus>(value),
    );
  }
}

String _$currentAuthStatusHash() => r'bc2901bb24345191eaf1ce8e249df1c08b51f70a';

@ProviderFor(isAuthenticated)
final isAuthenticatedProvider = IsAuthenticatedProvider._();

final class IsAuthenticatedProvider
    extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  IsAuthenticatedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isAuthenticatedProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isAuthenticatedHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return isAuthenticated(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$isAuthenticatedHash() => r'7603670f304ae3c6762c181732f404b9c25522f2';
