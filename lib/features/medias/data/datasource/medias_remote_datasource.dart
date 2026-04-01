import 'package:ibiapabaapp/features/medias/domain/entity/media.dart';

abstract class MediasRemoteDatasource {
  Future<List<Media>> getEntityMedia({
    required EntityType entityType,
    required String entityId,
  });
}
