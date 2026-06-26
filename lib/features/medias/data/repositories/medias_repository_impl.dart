import 'package:dio/dio.dart';
import 'package:ibiapabaapp/core/entities/entity_type.dart';
import 'package:ibiapabaapp/core/network/dio_exception_to_app_exception_mapper.dart';
import 'package:ibiapabaapp/features/medias/data/datasource/medias_remote_datasource.dart';
import 'package:ibiapabaapp/shared/models/media.dart';
import 'package:ibiapabaapp/features/medias/domain/repositories/medias_repository.dart';

class MediasRepositoryImpl implements MediasRepository {
  final MediasRemoteDatasource remoteDatasource;

  MediasRepositoryImpl({required this.remoteDatasource});

  @override
  Future<List<Media>> getEntityMedia({
    required EntityType entityType,
    required String entityId,
  }) async {
    try {
      final media = await remoteDatasource.getEntityMedia(
        entityType: entityType,
        entityId: entityId,
      );
      return media;
    } on DioException catch (e) {
      throw DioExceptionToAppExceptionMapper.map(e);
    }
  }
}
