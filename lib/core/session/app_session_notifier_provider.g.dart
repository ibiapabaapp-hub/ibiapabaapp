// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_session_notifier_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AppSessionNotifier)
final appSessionProvider = AppSessionNotifierProvider._();

final class AppSessionNotifierProvider
    extends $NotifierProvider<AppSessionNotifier, AppSession> {
  AppSessionNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appSessionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appSessionNotifierHash();

  @$internal
  @override
  AppSessionNotifier create() => AppSessionNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppSession value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppSession>(value),
    );
  }
}

String _$appSessionNotifierHash() =>
    r'06425167f91816890f5f347c5b12adc20a444b39';

abstract class _$AppSessionNotifier extends $Notifier<AppSession> {
  AppSession build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AppSession, AppSession>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AppSession, AppSession>,
              AppSession,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
