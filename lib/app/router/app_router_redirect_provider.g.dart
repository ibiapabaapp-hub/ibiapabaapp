// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_router_redirect_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(routerRedirect)
final routerRedirectProvider = RouterRedirectProvider._();

final class RouterRedirectProvider
    extends $FunctionalProvider<RedirectTarget, RedirectTarget, RedirectTarget>
    with $Provider<RedirectTarget> {
  RouterRedirectProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'routerRedirectProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$routerRedirectHash();

  @$internal
  @override
  $ProviderElement<RedirectTarget> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  RedirectTarget create(Ref ref) {
    return routerRedirect(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RedirectTarget value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RedirectTarget>(value),
    );
  }
}

String _$routerRedirectHash() => r'c2aab1d0a8adc6474228b9a617adc77c3ca2edad';
