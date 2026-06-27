// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(authRepository)
final authRepositoryProvider = AuthRepositoryProvider._();

final class AuthRepositoryProvider
    extends $FunctionalProvider<AuthRepository, AuthRepository, AuthRepository>
    with $Provider<AuthRepository> {
  AuthRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authRepositoryHash();

  @$internal
  @override
  $ProviderElement<AuthRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AuthRepository create(Ref ref) {
    return authRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthRepository>(value),
    );
  }
}

String _$authRepositoryHash() => r'cf957c53ffaa90803dd5e9adfae998770964ac9a';

@ProviderFor(loginController)
final loginControllerProvider = LoginControllerProvider._();

final class LoginControllerProvider
    extends
        $FunctionalProvider<LoginController, LoginController, LoginController>
    with $Provider<LoginController> {
  LoginControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'loginControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$loginControllerHash();

  @$internal
  @override
  $ProviderElement<LoginController> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  LoginController create(Ref ref) {
    return loginController(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LoginController value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LoginController>(value),
    );
  }
}

String _$loginControllerHash() => r'e38aaa7200bc0d681cbea704bf5b1a8cd96cee0c';
