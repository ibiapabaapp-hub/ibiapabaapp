// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_state_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AuthState)
final authStateProvider = AuthStateProvider._();

final class AuthStateProvider extends $NotifierProvider<AuthState, AuthData> {
  AuthStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authStateProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authStateHash();

  @$internal
  @override
  AuthState create() => AuthState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthData value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthData>(value),
    );
  }
}

String _$authStateHash() => r'385df07721a6d3402f0b1139392b9e701edd3d43';

abstract class _$AuthState extends $Notifier<AuthData> {
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

String _$currentAuthStatusHash() => r'a03c72fe361c136ee1ffeaa47c7c120879ff1cae';

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

String _$isAuthenticatedHash() => r'218691fd17c6b44fb74c3ffac9408787db617ed4';
