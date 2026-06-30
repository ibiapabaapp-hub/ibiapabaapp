// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'businesses_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(BusinessesViewModel)
final businessesViewModelProvider = BusinessesViewModelProvider._();

final class BusinessesViewModelProvider
    extends $AsyncNotifierProvider<BusinessesViewModel, List<Business>> {
  BusinessesViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'businessesViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$businessesViewModelHash();

  @$internal
  @override
  BusinessesViewModel create() => BusinessesViewModel();
}

String _$businessesViewModelHash() =>
    r'd7a948e73159371be6279d39c37b6922ed141202';

abstract class _$BusinessesViewModel extends $AsyncNotifier<List<Business>> {
  FutureOr<List<Business>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Business>>, List<Business>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Business>>, List<Business>>,
              AsyncValue<List<Business>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
