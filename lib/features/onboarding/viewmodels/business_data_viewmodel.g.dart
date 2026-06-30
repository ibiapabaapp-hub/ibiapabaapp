// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_data_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(BusinessDataViewModel)
final businessDataViewModelProvider = BusinessDataViewModelProvider._();

final class BusinessDataViewModelProvider
    extends $AsyncNotifierProvider<BusinessDataViewModel, BusinessDataState> {
  BusinessDataViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'businessDataViewModelProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$businessDataViewModelHash();

  @$internal
  @override
  BusinessDataViewModel create() => BusinessDataViewModel();
}

String _$businessDataViewModelHash() =>
    r'ed11d24ed92b0993315e942491c548f949e0895e';

abstract class _$BusinessDataViewModel
    extends $AsyncNotifier<BusinessDataState> {
  FutureOr<BusinessDataState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<BusinessDataState>, BusinessDataState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<BusinessDataState>, BusinessDataState>,
              AsyncValue<BusinessDataState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
