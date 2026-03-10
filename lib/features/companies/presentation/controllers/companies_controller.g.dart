// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'companies_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Companies)
final companiesProvider = CompaniesProvider._();

final class CompaniesProvider
    extends $AsyncNotifierProvider<Companies, List<Company>> {
  CompaniesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'companiesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$companiesHash();

  @$internal
  @override
  Companies create() => Companies();
}

String _$companiesHash() => r'61b7bb90ddbb393c50e0c71191a327d94eefade0';

abstract class _$Companies extends $AsyncNotifier<List<Company>> {
  FutureOr<List<Company>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Company>>, List<Company>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Company>>, List<Company>>,
              AsyncValue<List<Company>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
