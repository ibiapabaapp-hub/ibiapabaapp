import 'package:dartz/dartz.dart';
import 'package:ibiapabaapp/core/entities/entity_type.dart';
import 'package:ibiapabaapp/core/errors/failures/failures.dart';
import 'package:ibiapabaapp/shared/models/media.dart';
import 'package:ibiapabaapp/features/medias/domain/repositories/medias_repository.dart';

class GetEntityMedia {
  final MediasRepository repository;

  GetEntityMedia(this.repository);

  Future<Either<AppFailure, List<Media>>> call({
    required EntityType entityType,
    required String entityId,
  }) {
    return repository.getEntityMedia(
      entityType: entityType,
      entityId: entityId,
    );
  }
}
