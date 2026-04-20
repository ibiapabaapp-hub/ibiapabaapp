// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_preferences_state_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UserPreferencesState)
final userPreferencesStateProvider = UserPreferencesStateProvider._();

final class UserPreferencesStateProvider
    extends $NotifierProvider<UserPreferencesState, UserPreferences> {
  UserPreferencesStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userPreferencesStateProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userPreferencesStateHash();

  @$internal
  @override
  UserPreferencesState create() => UserPreferencesState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UserPreferences value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UserPreferences>(value),
    );
  }
}

String _$userPreferencesStateHash() =>
    r'59c528567bf128c9e183b9124ff316895f96d8f7';

abstract class _$UserPreferencesState extends $Notifier<UserPreferences> {
  UserPreferences build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<UserPreferences, UserPreferences>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<UserPreferences, UserPreferences>,
              UserPreferences,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
