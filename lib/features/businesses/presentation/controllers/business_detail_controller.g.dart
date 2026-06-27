// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_detail_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(BusinessDetail)
final businessDetailProvider = BusinessDetailFamily._();

final class BusinessDetailProvider
    extends $AsyncNotifierProvider<BusinessDetail, BusinessDetailData?> {
  BusinessDetailProvider._({
    required BusinessDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'businessDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$businessDetailHash();

  @override
  String toString() {
    return r'businessDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  BusinessDetail create() => BusinessDetail();

  @override
  bool operator ==(Object other) {
    return other is BusinessDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$businessDetailHash() => r'8ea613f6c0880ebb7860a0bbc63733cd8279e8a5';

final class BusinessDetailFamily extends $Family
    with
        $ClassFamilyOverride<
          BusinessDetail,
          AsyncValue<BusinessDetailData?>,
          BusinessDetailData?,
          FutureOr<BusinessDetailData?>,
          String
        > {
  BusinessDetailFamily._()
    : super(
        retry: null,
        name: r'businessDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  BusinessDetailProvider call(String id) =>
      BusinessDetailProvider._(argument: id, from: this);

  @override
  String toString() => r'businessDetailProvider';
}

abstract class _$BusinessDetail extends $AsyncNotifier<BusinessDetailData?> {
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
