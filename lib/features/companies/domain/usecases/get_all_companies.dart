import 'package:dartz/dartz.dart';
import 'package:ibiapabaapp/core/errors/failures/failures.dart';
import 'package:ibiapabaapp/features/companies/domain/entities/company.dart';
import 'package:ibiapabaapp/features/companies/domain/repositories/companies_repository.dart';

class GetAllCompanies {
  final CompaniesRepository repository;

  GetAllCompanies(this.repository);

  Future<Either<Failure, List<Company>>> call() {
    return repository.getAllCompanies();
  }
}
