import 'package:dartz/dartz.dart';
import 'package:ibiapabaapp/core/errors/failures/failures.dart';
import 'package:ibiapabaapp/features/companies/domain/entities/company.dart';

abstract class CompaniesRepository {
  Future<Either<Failure, List<Company>>> getAllCompanies();
  Future<Either<Failure, Company?>> getCompanyById(String id);
}
