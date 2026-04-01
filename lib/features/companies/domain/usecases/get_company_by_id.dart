import 'package:dartz/dartz.dart';
import 'package:ibiapabaapp/core/errors/failures/failures.dart';
import 'package:ibiapabaapp/features/companies/domain/entities/company.dart';
import 'package:ibiapabaapp/features/companies/domain/repositories/companies_repository.dart';

class GetCompanyById {
  final CompaniesRepository repository;
  GetCompanyById(this.repository);

  Future<Either<AppFailure, Company?>> call(String id) {
    return repository.getCompanyById(id);
  }
}
