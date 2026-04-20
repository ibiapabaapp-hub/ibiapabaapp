// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_preferences_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(userPreferencesStorage)
final userPreferencesStorageProvider = UserPreferencesStorageProvider._();

final class UserPreferencesStorageProvider
    extends
        $FunctionalProvider<
          UserPreferencesStorage,
          UserPreferencesStorage,
          UserPreferencesStorage
        >
    with $Provider<UserPreferencesStorage> {
  UserPreferencesStorageProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userPreferencesStorageProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userPreferencesStorageHash();

  @$internal
  @override
  $ProviderElement<UserPreferencesStorage> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  UserPreferencesStorage create(Ref ref) {
    return userPreferencesStorage(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UserPreferencesStorage value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UserPreferencesStorage>(value),
    );
  }
}

String _$userPreferencesStorageHash() =>
    r'ee27f7bbfd57ef1c3b47038c6ba7f5cee548022b';
