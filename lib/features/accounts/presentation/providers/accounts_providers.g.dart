// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accounts_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(accountsLocalStorage)
final accountsLocalStorageProvider = AccountsLocalStorageProvider._();

final class AccountsLocalStorageProvider
    extends
        $FunctionalProvider<
          AccountsLocalStorage,
          AccountsLocalStorage,
          AccountsLocalStorage
        >
    with $Provider<AccountsLocalStorage> {
  AccountsLocalStorageProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'accountsLocalStorageProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$accountsLocalStorageHash();

  @$internal
  @override
  $ProviderElement<AccountsLocalStorage> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AccountsLocalStorage create(Ref ref) {
    return accountsLocalStorage(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AccountsLocalStorage value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AccountsLocalStorage>(value),
    );
  }
}

String _$accountsLocalStorageHash() =>
    r'51f3b6aa54ed9cfc0ec0b0e85323317a5d8ee9b7';

@ProviderFor(accountsRepository)
final accountsRepositoryProvider = AccountsRepositoryProvider._();

final class AccountsRepositoryProvider
    extends
        $FunctionalProvider<
          AccountsRepository,
          AccountsRepository,
          AccountsRepository
        >
    with $Provider<AccountsRepository> {
  AccountsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'accountsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$accountsRepositoryHash();

  @$internal
  @override
  $ProviderElement<AccountsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AccountsRepository create(Ref ref) {
    return accountsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AccountsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AccountsRepository>(value),
    );
  }
}

String _$accountsRepositoryHash() =>
    r'0c9429c25113c3717b3837401765af0c4f21c00f';
