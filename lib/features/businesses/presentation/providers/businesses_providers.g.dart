// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'businesses_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(businessesRepository)
final businessesRepositoryProvider = BusinessesRepositoryProvider._();

final class BusinessesRepositoryProvider
    extends
        $FunctionalProvider<
          BusinessesRepository,
          BusinessesRepository,
          BusinessesRepository
        >
    with $Provider<BusinessesRepository> {
  BusinessesRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'businessesRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$businessesRepositoryHash();

  @$internal
  @override
  $ProviderElement<BusinessesRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  BusinessesRepository create(Ref ref) {
    return businessesRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BusinessesRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BusinessesRepository>(value),
    );
  }
}

String _$businessesRepositoryHash() =>
    r'7bd6d417fe6e1f8169806bd1d5d6385281c7b566';
