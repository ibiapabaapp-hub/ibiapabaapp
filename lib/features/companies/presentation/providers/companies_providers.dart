import 'package:ibiapabaapp/core/network/dio_provider.dart';
import 'package:ibiapabaapp/features/companies/data/datasource/companies_remote_datasource.dart';
import 'package:ibiapabaapp/features/companies/data/repositories/companies_repository_impl.dart';
import 'package:ibiapabaapp/features/companies/domain/repositories/companies_repository.dart';
import 'package:ibiapabaapp/features/companies/domain/usecases/get_all_companies.dart';
import 'package:ibiapabaapp/features/companies/domain/usecases/get_company_by_id.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'companies_providers.g.dart';

// DATA
@riverpod
CompaniesRemoteDatasource companiesRemoteDatasource(Ref ref) {
  final dio = ref.watch(dioProvider);
  return CompaniesRemoteDatasourceImpl(dio);
}

@riverpod
CompaniesRepository companiesRepository(Ref ref) {
  final remoteDatasource = ref.watch(companiesRemoteDatasourceProvider);

  return CompaniesRepositoryImpl(remoteDatasource: remoteDatasource);
}

// USECASES
@riverpod
GetAllCompanies getAllCompanies(Ref ref) {
  final repository = ref.watch(companiesRepositoryProvider);
  return GetAllCompanies(repository);
}

@riverpod
GetCompanyById getCompanyById(Ref ref) {
  final repository = ref.watch(companiesRepositoryProvider);
  return GetCompanyById(repository);
}
