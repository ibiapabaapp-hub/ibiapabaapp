import 'package:dartz/dartz.dart';
import 'package:ibiapabaapp/core/errors/exceptions/exceptions.dart';
import 'package:ibiapabaapp/core/errors/exceptions/global_exception_to_failure_mapper.dart';
import 'package:ibiapabaapp/core/errors/failures/failures.dart';
import 'package:ibiapabaapp/core/logger/log_tags.dart';
import 'package:ibiapabaapp/core/logger/logger.dart';
import 'package:ibiapabaapp/features/companies/data/datasource/companies_remote_datasource.dart';
import 'package:ibiapabaapp/features/companies/domain/entities/company.dart';
import 'package:ibiapabaapp/features/companies/domain/repositories/companies_repository.dart';

class CompaniesRepositoryImpl implements CompaniesRepository {
  final CompaniesRemoteDatasource remoteDatasource;
  CompaniesRepositoryImpl({required this.remoteDatasource});

  Failure _handleError(dynamic e, StackTrace stack, String tag) {
    final code = e is AppException ? e.code : null;
    logger.e(
      '${LogTags.repository}${LogTags.cities}$tag',
      error: {
        'exception': e.runtimeType.toString(),
        'code': code,
        'message': e.toString(),
      },
      stackTrace: stack,
    );

    // TODO: CitiesExceptionToFailureMapper para erros específicos da funcionalidade
    return GlobalExceptionToFailureMapper.map(e);
  }

  @override
  Future<Either<Failure, List<Company>>> getAllCompanies() async {
    try {
      final remoteCities = await remoteDatasource.getAllCompanies();
      return Right(remoteCities);
    } catch (e, stack) {
      return Left(_handleError(e, stack, LogTags.getAllCities));
    }
  }

  @override
  Future<Either<Failure, Company?>> getCompanyById(String id) async {
    try {
      final company = await remoteDatasource.getCompanyById(id);
      return Right(company);
    } catch (e, stack) {
      return Left(_handleError(e, stack, LogTags.getCityById));
    }
  }
}
