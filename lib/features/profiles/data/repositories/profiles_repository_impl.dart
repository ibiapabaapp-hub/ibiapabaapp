import 'package:dartz/dartz.dart';
import 'package:ibiapabaapp/core/errors/failures/failures.dart';
import 'package:ibiapabaapp/core/logger/log_tags.dart';
import 'package:ibiapabaapp/core/logger/handlers/repository_log_handler.dart';
import 'package:ibiapabaapp/features/profiles/data/datasources/profiles_remote_datasource.dart';
import 'package:ibiapabaapp/features/profiles/domain/entities/profile.dart';
import 'package:ibiapabaapp/features/profiles/domain/entities/profile_interests.dart';
import 'package:ibiapabaapp/features/profiles/domain/entities/profile_interests_response.dart';
import 'package:ibiapabaapp/features/profiles/domain/repositories/profiles_repository.dart';
import 'package:ibiapabaapp/features/profiles/domain/tags/profiles_logtags.dart';
import 'package:logger/logger.dart';

class ProfilesRepositoryImpl
    with RepositoryLogHandler
    implements ProfilesRepository {
  @override
  final Logger logger;
  final ProfilesRemoteDatasource remoteDatasource;

  ProfilesRepositoryImpl({
    required this.remoteDatasource,
    required this.logger,
  });

  @override
  LogFeature get feature => LogFeature.profiles;

  @override
  Future<Either<AppFailure, List<Profile>>> getAccountProfiles() async {
    try {
      // TODO: guardar em cache
      return await remoteDatasource.getAccountProfiles();
    } catch (e, stack) {
      return Left(
        handleRepositoryError(
          exception: e,
          stackTrace: stack,
          action: ProfileAction.getAccountProfiles,
        ),
      );
    }
  }

  @override
  Future<Either<AppFailure, ProfileInterests>> getProfileInterests(
    String profileId,
  ) async {
    try {
      // TODO: guardar em cache
      return await remoteDatasource.getProfileInterests(profileId);
    } catch (e, stack) {
      return Left(
        handleRepositoryError(
          exception: e,
          stackTrace: stack,
          action: ProfileAction.getProfileInterests,
        ),
      );
    }
  }

  @override
  Future<Either<AppFailure, ProfileInterestsResponse>> updateProfileInterests({
    required String profileId,
    required ProfileInterests interests,
  }) async {
    try {
      // TODO: guardar em cache
      return await remoteDatasource.updateProfileInterests(
        profileId: profileId,
        interests: interests,
      );
    } catch (e, stack) {
      return Left(
        handleRepositoryError(
          exception: e,
          stackTrace: stack,
          action: ProfileAction.getProfileInterests,
        ),
      );
    }
  }
}
