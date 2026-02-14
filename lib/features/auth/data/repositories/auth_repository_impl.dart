import 'package:dartz/dartz.dart';
import 'package:ibiapabaapp/core/errors/exceptions/exceptions.dart';
import 'package:ibiapabaapp/core/errors/failures/failures.dart';
import 'package:ibiapabaapp/core/logger/log_tags.dart';
import 'package:ibiapabaapp/core/logger/logger.dart';
import 'package:ibiapabaapp/data/secure_storage/tokens/token_storage.dart';
import 'package:ibiapabaapp/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:ibiapabaapp/features/auth/data/mappers/auth_exception_to_failure_mapper.dart';
import 'package:ibiapabaapp/features/auth/domain/entities/register_form_data.dart';
import 'package:ibiapabaapp/features/auth/domain/entities/auth_result.dart';
import 'package:ibiapabaapp/features/auth/domain/entities/check_availability.dart';
import 'package:ibiapabaapp/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource datasource;

  AuthRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, AuthResult>> login({
    required String email,
    required String password,
  }) async {
    try {
      final result = await datasource.login(email: email, password: password);
      await TokenStorageImpl.instance.saveTokens(result);
      return Right(result);
    } catch (e, stack) {
      final code = e is AppException ? e.code : null;
      logger.e(
        '${LogTags.repository}${LogTags.auth}${LogTags.login}',
        error: {
          'exception': e.runtimeType.toString(),
          'code': code,
          'message': e.toString(),
        },
        stackTrace: stack,
      );

      return Left(e.mapAuthExceptionToFailure());
    }
  }

  @override
  Future<Either<Failure, AuthResult>> register({
    required RegisterFormData registerFormData,
  }) async {
    try {
      final result = await datasource.register(
        registerFormData: registerFormData,
      );
      await TokenStorageImpl.instance.saveTokens(result);
      return Right(result);
    } catch (e, stack) {
      final code = e is AppException ? e.code : null;
      logger.e(
        '${LogTags.repository}${LogTags.auth}${LogTags.register}',
        error: {
          'exception': e.runtimeType.toString(),
          'code': code,
          'message': e.toString(),
        },
        stackTrace: stack,
      );

      return Left(e.mapAuthExceptionToFailure());
    }
  }

  @override
  Future<Either<Failure, CheckAvailability>> checkAvailability({
    required String field,
    required String value,
  }) async {
    try {
      final result = await datasource.checkAvailability(
        field: field,
        value: value,
      );
      return Right(result);
    } catch (e, stack) {
      final code = e is AppException ? e.code : null;
      logger.e(
        '${LogTags.repository}${LogTags.auth}${LogTags.checkUsername}',
        error: {
          'exception': e.runtimeType.toString(),
          'code': code,
          'message': e.toString(),
        },
        stackTrace: stack,
      );

      return Left(e.mapAuthExceptionToFailure());
    }
  }
}
