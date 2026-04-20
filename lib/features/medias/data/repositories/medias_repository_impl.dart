import 'package:dartz/dartz.dart';
import 'package:ibiapabaapp/core/entities/entity_type.dart';
import 'package:ibiapabaapp/core/errors/failures/failures.dart';
import 'package:ibiapabaapp/core/logger/log_tags.dart';
import 'package:ibiapabaapp/core/logger/handlers/repository_log_handler.dart';
import 'package:ibiapabaapp/features/medias/data/datasource/medias_remote_datasource.dart';
import 'package:ibiapabaapp/features/medias/domain/entity/media.dart';
import 'package:ibiapabaapp/features/medias/domain/repositories/medias_repository.dart';
import 'package:logger/logger.dart';

class MediasRepositoryImpl
    with RepositoryLogHandler
    implements MediasRepository {
  @override
  final Logger logger;
  final MediasRemoteDatasource remoteDatasource;

  MediasRepositoryImpl({required this.remoteDatasource, required this.logger});

  @override
  LogFeature get feature => LogFeature.medias;

  @override
  Future<Either<AppFailure, List<Media>>> getEntityMedia({
    required EntityType entityType,
    required String entityId,
  }) async {
    try {
      final media = await remoteDatasource.getEntityMedia(
        entityType: entityType,
        entityId: entityId,
      );
      return Right(media);
    } catch (e, stack) {
      return Left(
        handleRepositoryError(
          exception: e,
          stackTrace: stack,
          action: MediaAction.getEntityMedia,
        ),
      );
    }
  }
}
