// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_interests_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AccountInterestsViewModel)
final accountInterestsViewModelProvider = AccountInterestsViewModelProvider._();

final class AccountInterestsViewModelProvider
    extends
        $NotifierProvider<AccountInterestsViewModel, AccountInterestsState> {
  AccountInterestsViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'accountInterestsViewModelProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$accountInterestsViewModelHash();

  @$internal
  @override
  AccountInterestsViewModel create() => AccountInterestsViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AccountInterestsState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AccountInterestsState>(value),
    );
  }
}

String _$accountInterestsViewModelHash() =>
    r'33a4eefc1190dfba2243a6b80b82a3015c82f090';

abstract class _$AccountInterestsViewModel
    extends $Notifier<AccountInterestsState> {
  AccountInterestsState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AccountInterestsState, AccountInterestsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AccountInterestsState, AccountInterestsState>,
              AccountInterestsState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
