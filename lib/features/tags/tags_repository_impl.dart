import 'package:dio/dio.dart';
import 'package:ibivibe/core/logger/handlers/repository_log_handler.dart';
import 'package:ibivibe/core/logger/log_tags.dart';
import 'package:ibivibe/core/network/dio_exception_to_app_exception_mapper.dart';
import 'package:ibivibe/shared/models/tag_group.dart';
import 'package:ibivibe/features/tags/tags_repository.dart';
import 'package:ibivibe/features/tags/models/tag_group_model.dart';
import 'package:logger/logger.dart';

class TagsRepositoryImpl
    with RepositoryLogHandler
    implements TagsRepository {
  @override
  final Logger logger;
  @override
  LogFeature get feature => LogFeature.tags;

  final Dio dio;

  TagsRepositoryImpl({
    required this.logger,
    required this.dio,
  });

  @override
  Future<List<TagGroup>> getTagGroups() async {
    try {
      final response = await dio.get('/tags/groups');
      final data = response.data;

      if (data is List) {
        return TagGroupModel.fromJsonList(data);
      }

      return [];
    } on DioException catch (e) {
      throw DioExceptionToAppExceptionMapper.map(e);
    }
  }
}
