// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'companies_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(companiesRemoteDatasource)
final companiesRemoteDatasourceProvider = CompaniesRemoteDatasourceProvider._();

final class CompaniesRemoteDatasourceProvider
    extends
        $FunctionalProvider<
          CompaniesRemoteDatasource,
          CompaniesRemoteDatasource,
          CompaniesRemoteDatasource
        >
    with $Provider<CompaniesRemoteDatasource> {
  CompaniesRemoteDatasourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'companiesRemoteDatasourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$companiesRemoteDatasourceHash();

  @$internal
  @override
  $ProviderElement<CompaniesRemoteDatasource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CompaniesRemoteDatasource create(Ref ref) {
    return companiesRemoteDatasource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CompaniesRemoteDatasource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CompaniesRemoteDatasource>(value),
    );
  }
}

String _$companiesRemoteDatasourceHash() =>
    r'ae4aa83e21f921a0717249e3a148ce11216d1d15';

@ProviderFor(companiesRepository)
final companiesRepositoryProvider = CompaniesRepositoryProvider._();

final class CompaniesRepositoryProvider
    extends
        $FunctionalProvider<
          CompaniesRepository,
          CompaniesRepository,
          CompaniesRepository
        >
    with $Provider<CompaniesRepository> {
  CompaniesRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'companiesRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$companiesRepositoryHash();

  @$internal
  @override
  $ProviderElement<CompaniesRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CompaniesRepository create(Ref ref) {
    return companiesRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CompaniesRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CompaniesRepository>(value),
    );
  }
}

String _$companiesRepositoryHash() =>
    r'7be9d1f9f2963d6b5208f075f772f739aa40da11';

@ProviderFor(getAllCompanies)
final getAllCompaniesProvider = GetAllCompaniesProvider._();

final class GetAllCompaniesProvider
    extends
        $FunctionalProvider<GetAllCompanies, GetAllCompanies, GetAllCompanies>
    with $Provider<GetAllCompanies> {
  GetAllCompaniesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getAllCompaniesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getAllCompaniesHash();

  @$internal
  @override
  $ProviderElement<GetAllCompanies> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetAllCompanies create(Ref ref) {
    return getAllCompanies(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetAllCompanies value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetAllCompanies>(value),
    );
  }
}

String _$getAllCompaniesHash() => r'643170de5a6c3f6a76f96ab5deb91f8f6a3e37e2';

@ProviderFor(getCompanyById)
final getCompanyByIdProvider = GetCompanyByIdProvider._();

final class GetCompanyByIdProvider
    extends $FunctionalProvider<GetCompanyById, GetCompanyById, GetCompanyById>
    with $Provider<GetCompanyById> {
  GetCompanyByIdProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getCompanyByIdProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getCompanyByIdHash();

  @$internal
  @override
  $ProviderElement<GetCompanyById> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetCompanyById create(Ref ref) {
    return getCompanyById(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetCompanyById value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetCompanyById>(value),
    );
  }
}

String _$getCompanyByIdHash() => r'b13a976c921c2943b1eac9fcf2251e3d7af0654d';
