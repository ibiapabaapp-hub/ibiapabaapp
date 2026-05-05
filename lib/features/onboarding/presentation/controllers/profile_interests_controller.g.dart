// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_interests_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ProfileInterestsController)
final profileInterestsControllerProvider =
    ProfileInterestsControllerProvider._();

final class ProfileInterestsControllerProvider
    extends
        $NotifierProvider<ProfileInterestsController, ProfileInterestsState> {
  ProfileInterestsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'profileInterestsControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$profileInterestsControllerHash();

  @$internal
  @override
  ProfileInterestsController create() => ProfileInterestsController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProfileInterestsState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProfileInterestsState>(value),
    );
  }
}

String _$profileInterestsControllerHash() =>
    r'16375809431028c99170eae831c9e65dfbea45fe';

abstract class _$ProfileInterestsController
    extends $Notifier<ProfileInterestsState> {
  ProfileInterestsState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ProfileInterestsState, ProfileInterestsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ProfileInterestsState, ProfileInterestsState>,
              ProfileInterestsState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
