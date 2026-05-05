// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_data_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(BusinessDataController)
final businessDataControllerProvider = BusinessDataControllerProvider._();

final class BusinessDataControllerProvider
    extends $AsyncNotifierProvider<BusinessDataController, BusinessDataState> {
  BusinessDataControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'businessDataControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$businessDataControllerHash();

  @$internal
  @override
  BusinessDataController create() => BusinessDataController();
}

String _$businessDataControllerHash() =>
    r'4a8113671c72cb71df53a658b4cc1acc1fe6118a';

abstract class _$BusinessDataController
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
