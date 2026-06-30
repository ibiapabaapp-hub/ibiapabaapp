// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city_detail_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CityDetailViewModel)
final cityDetailViewModelProvider = CityDetailViewModelFamily._();

final class CityDetailViewModelProvider
    extends $AsyncNotifierProvider<CityDetailViewModel, CityDetailData?> {
  CityDetailViewModelProvider._({
    required CityDetailViewModelFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'cityDetailViewModelProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$cityDetailViewModelHash();

  @override
  String toString() {
    return r'cityDetailViewModelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  CityDetailViewModel create() => CityDetailViewModel();

  @override
  bool operator ==(Object other) {
    return other is CityDetailViewModelProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$cityDetailViewModelHash() =>
    r'222ee31793ddd7b88884af389dab109211409c14';

final class CityDetailViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          CityDetailViewModel,
          AsyncValue<CityDetailData?>,
          CityDetailData?,
          FutureOr<CityDetailData?>,
          String
        > {
  CityDetailViewModelFamily._()
    : super(
        retry: null,
        name: r'cityDetailViewModelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CityDetailViewModelProvider call(String id) =>
      CityDetailViewModelProvider._(argument: id, from: this);

  @override
  String toString() => r'cityDetailViewModelProvider';
}

abstract class _$CityDetailViewModel extends $AsyncNotifier<CityDetailData?> {
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
