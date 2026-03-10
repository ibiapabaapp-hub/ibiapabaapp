import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ibiapabaapp/core/errors/failures/failures.dart';
import 'package:ibiapabaapp/core/logger/logger.dart';
import 'package:ibiapabaapp/features/auth/presentation/providers/session_provider.dart';
import 'package:ibiapabaapp/features/companies/domain/entities/company.dart';
import 'package:ibiapabaapp/features/companies/domain/entities/company_detail_data.dart';
import 'package:ibiapabaapp/features/companies/presentation/providers/companies_providers.dart';
import 'package:ibiapabaapp/features/medias/domain/entity/media.dart';
import 'package:ibiapabaapp/features/medias/presentation/providers/medias_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'company_detail_controller.g.dart';

@riverpod
class CompanyDetail extends _$CompanyDetail {
  @override
  Future<CompanyDetailData?> build(String id) async {
    final session = ref.watch(sessionProvider.select((s) => s));
    if (session == null) return null;

    final results = await Future.wait([
      ref.read(getCompanyByIdProvider).call(id),
      ref
          .read(getEntityMediaProvider)
          .call(entityType: EntityType.company, entityId: id),
    ]);

    final companyResult = results[0] as Either<Failure, Company?>;
    final mediaResult = results[1] as Either<Failure, List<Media>>;

    final company = companyResult.fold(
      (failure) => throw Exception(failure.message),
      (companyData) => companyData,
    );

    if (company == null) return null;

    final media = mediaResult.fold((failure) {
      logger.w('Falha ao carregar mídia da empresa $id: ${failure.message}');
      return <Media>[];
    }, (media) => media);

    return CompanyDetailData(company: company, media: media);
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    // ref.invalidateSelf() força o build() a reexecutar corretamente
    ref.invalidateSelf();
    await future;
  }
}
