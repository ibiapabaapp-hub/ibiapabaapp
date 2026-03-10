// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_detail_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CompanyDetail)
final companyDetailProvider = CompanyDetailFamily._();

final class CompanyDetailProvider
    extends $AsyncNotifierProvider<CompanyDetail, CompanyDetailData?> {
  CompanyDetailProvider._({
    required CompanyDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'companyDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$companyDetailHash();

  @override
  String toString() {
    return r'companyDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  CompanyDetail create() => CompanyDetail();

  @override
  bool operator ==(Object other) {
    return other is CompanyDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$companyDetailHash() => r'e11ac6e472e70bb71233dce64d4453cbd0231157';

final class CompanyDetailFamily extends $Family
    with
        $ClassFamilyOverride<
          CompanyDetail,
          AsyncValue<CompanyDetailData?>,
          CompanyDetailData?,
          FutureOr<CompanyDetailData?>,
          String
        > {
  CompanyDetailFamily._()
    : super(
        retry: null,
        name: r'companyDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CompanyDetailProvider call(String id) =>
      CompanyDetailProvider._(argument: id, from: this);

  @override
  String toString() => r'companyDetailProvider';
}

abstract class _$CompanyDetail extends $AsyncNotifier<CompanyDetailData?> {
  late final _$args = ref.$arg as String;
  String get id => _$args;

  FutureOr<CompanyDetailData?> build(String id);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<CompanyDetailData?>, CompanyDetailData?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<CompanyDetailData?>, CompanyDetailData?>,
              AsyncValue<CompanyDetailData?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
