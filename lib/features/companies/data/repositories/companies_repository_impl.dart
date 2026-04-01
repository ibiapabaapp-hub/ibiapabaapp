import 'package:dartz/dartz.dart';
import 'package:ibiapabaapp/core/errors/failures/failures.dart';
import 'package:ibiapabaapp/core/logger/log_tags.dart';
import 'package:ibiapabaapp/core/logger/handlers/repository_log_handler.dart';
import 'package:ibiapabaapp/features/companies/data/datasource/companies_remote_datasource.dart';
import 'package:ibiapabaapp/features/companies/domain/entities/company.dart';
import 'package:ibiapabaapp/features/companies/domain/repositories/companies_repository.dart';
import 'package:logger/logger.dart';

class CompaniesRepositoryImpl
    with RepositoryLogHandler
    implements CompaniesRepository {
  @override
  final Logger logger;
  final CompaniesRemoteDatasource remoteDatasource;

  CompaniesRepositoryImpl({
    required this.remoteDatasource,
    required this.logger,
  });

  @override
  LogFeature get feature => LogFeature.companies;

  @override
  Future<Either<AppFailure, List<Company>>> getAllCompanies() async {
    try {
      final result = await remoteDatasource.getAllCompanies();
      return Right(result);
    } catch (e, stack) {
      return Left(
        handleRepositoryError(
          exception: e,
          stackTrace: stack,
          action: CompanyAction.getAllCompanies,
        ),
      );
    }
  }

  @override
  Future<Either<AppFailure, Company?>> getCompanyById(String id) async {
    try {
      final result = await remoteDatasource.getCompanyById(id);
      return Right(result);
    } catch (e, stack) {
      return Left(
        handleRepositoryError(
          exception: e,
          stackTrace: stack,
          action: CompanyAction.getCompanyById,
        ),
      );
    }
  }
}
