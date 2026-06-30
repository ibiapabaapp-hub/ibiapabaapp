// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_detail_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(BusinessDetailViewModel)
final businessDetailViewModelProvider = BusinessDetailViewModelFamily._();

final class BusinessDetailViewModelProvider
    extends
        $AsyncNotifierProvider<BusinessDetailViewModel, BusinessDetailData?> {
  BusinessDetailViewModelProvider._({
    required BusinessDetailViewModelFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'businessDetailViewModelProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$businessDetailViewModelHash();

  @override
  String toString() {
    return r'businessDetailViewModelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  BusinessDetailViewModel create() => BusinessDetailViewModel();

  @override
  bool operator ==(Object other) {
    return other is BusinessDetailViewModelProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$businessDetailViewModelHash() =>
    r'26086ee8d5a30affde943ea7851aa3d424f80df9';

final class BusinessDetailViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          BusinessDetailViewModel,
          AsyncValue<BusinessDetailData?>,
          BusinessDetailData?,
          FutureOr<BusinessDetailData?>,
          String
        > {
  BusinessDetailViewModelFamily._()
    : super(
        retry: null,
        name: r'businessDetailViewModelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  BusinessDetailViewModelProvider call(String id) =>
      BusinessDetailViewModelProvider._(argument: id, from: this);

  @override
  String toString() => r'businessDetailViewModelProvider';
}

abstract class _$BusinessDetailViewModel
    extends $AsyncNotifier<BusinessDetailData?> {
  late final _$args = ref.$arg as String;
  String get id => _$args;

  FutureOr<BusinessDetailData?> build(String id);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<BusinessDetailData?>, BusinessDetailData?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<BusinessDetailData?>, BusinessDetailData?>,
              AsyncValue<BusinessDetailData?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
