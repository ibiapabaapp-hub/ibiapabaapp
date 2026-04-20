import 'package:dio/dio.dart';
import 'package:ibiapabaapp/core/entities/entity_type.dart';
import 'package:ibiapabaapp/core/network/dio_exception_to_app_exception_mapper.dart';
import 'package:ibiapabaapp/features/medias/data/datasource/medias_remote_datasource.dart';
import 'package:ibiapabaapp/features/medias/infra/models/media_model.dart';
import 'package:ibiapabaapp/features/medias/domain/entity/media.dart';

class MediasRemoteDatasourceImpl implements MediasRemoteDatasource {
  final Dio dio;
  MediasRemoteDatasourceImpl(this.dio);

  @override
  Future<List<Media>> getEntityMedia({
    required EntityType entityType,
    required String entityId,
  }) async {
    try {
      final response = await dio.get(
        '/${entityType.pathSegment}/$entityId/media',
      );
      return MediaModel.fromJsonList(response.data);
    } on DioException catch (e) {
      throw DioExceptionToAppExceptionMapper.map(e);
    }
  }
}
