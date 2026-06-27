import 'package:ibivibe/core/entities/entity_type.dart';
import 'package:ibivibe/shared/models/media.dart';

abstract class MediasRepository {
  Future<List<Media>> getEntityMedia({
    required EntityType entityType,
    required String entityId,
  });
}
