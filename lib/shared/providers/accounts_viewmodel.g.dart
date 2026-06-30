// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accounts_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AccountsViewModel)
final accountsViewModelProvider = AccountsViewModelProvider._();

final class AccountsViewModelProvider
    extends $NotifierProvider<AccountsViewModel, AccountsData> {
  AccountsViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'accountsViewModelProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$accountsViewModelHash();

  @$internal
  @override
  AccountsViewModel create() => AccountsViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AccountsData value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AccountsData>(value),
    );
  }
}

String _$accountsViewModelHash() => r'4012defeb93a929649e3b7f3b55ff32b3a37d4ee';

abstract class _$AccountsViewModel extends $Notifier<AccountsData> {
  AccountsData build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AccountsData, AccountsData>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AccountsData, AccountsData>,
              AccountsData,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
