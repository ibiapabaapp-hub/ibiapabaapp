import 'package:ibiapabaapp/core/entities/entity_type.dart';
import 'package:ibiapabaapp/shared/models/media.dart';

abstract class MediasRepository {
  Future<List<Media>> getEntityMedia({
    required EntityType entityType,
    required String entityId,
  });
}
