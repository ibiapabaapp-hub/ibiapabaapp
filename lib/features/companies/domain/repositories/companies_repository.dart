import 'package:dartz/dartz.dart';
import 'package:ibiapabaapp/core/errors/failures/failures.dart';
import 'package:ibiapabaapp/features/companies/domain/entities/company.dart';

abstract class CompaniesRepository {
  Future<Either<AppFailure, List<Company>>> getAllCompanies();
  Future<Either<AppFailure, Company?>> getCompanyById(String id);
}
