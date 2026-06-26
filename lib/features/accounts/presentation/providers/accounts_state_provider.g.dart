// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accounts_state_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AccountsState)
final accountsStateProvider = AccountsStateProvider._();

final class AccountsStateProvider
    extends $NotifierProvider<AccountsState, AccountsData> {
  AccountsStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'accountsStateProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$accountsStateHash();

  @$internal
  @override
  AccountsState create() => AccountsState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AccountsData value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AccountsData>(value),
    );
  }
}

String _$accountsStateHash() => r'ac323fe808a434972635b005055a40653cf7b28a';

abstract class _$AccountsState extends $Notifier<AccountsData> {
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
