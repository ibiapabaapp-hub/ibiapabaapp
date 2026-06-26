// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city_detail_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CityDetail)
final cityDetailProvider = CityDetailFamily._();

final class CityDetailProvider
    extends $AsyncNotifierProvider<CityDetail, CityDetailData?> {
  CityDetailProvider._({
    required CityDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'cityDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$cityDetailHash();

  @override
  String toString() {
    return r'cityDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  CityDetail create() => CityDetail();

  @override
  bool operator ==(Object other) {
    return other is CityDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$cityDetailHash() => r'79146c7f81b57de280a6c98c9ba4ee6b03452b1e';

final class CityDetailFamily extends $Family
    with
        $ClassFamilyOverride<
          CityDetail,
          AsyncValue<CityDetailData?>,
          CityDetailData?,
          FutureOr<CityDetailData?>,
          String
        > {
  CityDetailFamily._()
    : super(
        retry: null,
        name: r'cityDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CityDetailProvider call(String id) =>
      CityDetailProvider._(argument: id, from: this);

  @override
  String toString() => r'cityDetailProvider';
}

abstract class _$CityDetail extends $AsyncNotifier<CityDetailData?> {
  late final _$args = ref.$arg as String;
  String get id => _$args;

  FutureOr<CityDetailData?> build(String id);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<CityDetailData?>, CityDetailData?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<CityDetailData?>, CityDetailData?>,
              AsyncValue<CityDetailData?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
