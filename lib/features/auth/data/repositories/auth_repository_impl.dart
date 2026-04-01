import 'package:dartz/dartz.dart';
import 'package:ibiapabaapp/core/errors/failures/failures.dart';
import 'package:ibiapabaapp/core/logger/log_tags.dart';
import 'package:ibiapabaapp/core/logger/handlers/repository_log_handler.dart';
import 'package:ibiapabaapp/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:ibiapabaapp/features/auth/data/mappers/auth_exception_to_failure_mapper.dart';
import 'package:ibiapabaapp/features/auth/domain/entities/register_form_data.dart';
import 'package:ibiapabaapp/features/auth/domain/entities/auth_result.dart';
import 'package:ibiapabaapp/features/auth/domain/entities/check_availability.dart';
import 'package:ibiapabaapp/features/auth/domain/entities/user.dart';
import 'package:ibiapabaapp/features/auth/domain/repositories/auth_repository.dart';
import 'package:logger/logger.dart';

class AuthRepositoryImpl with RepositoryLogHandler implements AuthRepository {
  @override
  final Logger logger;
  final AuthRemoteDatasource datasource;

  AuthRepositoryImpl({required this.datasource, required this.logger});

  @override
  AppFailure Function(Object) get featureMapper =>
      AuthExceptionToFailureMapper.map;

  @override
  LogFeature get feature => LogFeature.auth;

  @override
  Future<Either<AppFailure, AuthResult>> login({
    required String email,
    required String password,
  }) async {
    try {
      final result = await datasource.login(email: email, password: password);
      return Right(result);
    } catch (e, stack) {
      return Left(
        handleRepositoryError(
          exception: e,
          stackTrace: stack,
          action: AuthAction.login,
        ),
      );
    }
  }

  @override
  Future<Either<AppFailure, AuthResult>> register({
    required RegisterFormData registerFormData,
  }) async {
    try {
      final result = await datasource.register(
        registerFormData: registerFormData,
      );
      return Right(result);
    } catch (e, stack) {
      return Left(
        handleRepositoryError(
          exception: e,
          stackTrace: stack,
          action: AuthAction.register,
        ),
      );
    }
  }

  @override
  Future<Either<AppFailure, CheckAvailability>> checkAvailability({
    required AvailabilityField field,
    required String value,
  }) async {
    try {
      final result = await datasource.checkAvailability(
        field: field.value,
        value: value,
      );
      return Right(result);
    } catch (e, stack) {
      return Left(
        handleRepositoryError(
          exception: e,
          stackTrace: stack,
          action: AuthAction.checkAvailability,
        ),
      );
    }
  }

  @override
  Future<Either<AppFailure, User>> getMe() async {
    try {
      final result = await datasource.getMe();
      return Right(result);
    } catch (e, stack) {
      return Left(
        handleRepositoryError(
          exception: e,
          stackTrace: stack,
          action: AuthAction.getMe,
        ),
      );
    }
  }

  @override
  Future<Either<AppFailure, AuthResult>> refreshTokens() async {
    try {
      final result = await datasource.refreshTokens();
      return Right(result);
    } catch (e, stack) {
      return Left(
        handleRepositoryError(
          exception: e,
          stackTrace: stack,
          action: AuthAction.refreshTokens,
        ),
      );
    }
  }
}
