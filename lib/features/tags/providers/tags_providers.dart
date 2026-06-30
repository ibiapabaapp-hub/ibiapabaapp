import 'package:ibivibe/core/logger/logger.dart';
import 'package:ibivibe/core/network/dio_provider.dart';
import 'package:ibivibe/features/tags/tags_repository_impl.dart';
import 'package:ibivibe/shared/models/tag_group.dart';
import 'package:ibivibe/features/tags/tags_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tags_providers.g.dart';

@riverpod
TagsRepository tagsRepository(Ref ref) {
  final logger = ref.read(loggerProvider);
  final dio = ref.watch(dioProvider);

  return TagsRepositoryImpl(
    dio: dio,
    logger: logger,
  );
}

@riverpod
Future<List<TagGroup>> tagGroups(Ref ref) {
  final repository = ref.watch(tagsRepositoryProvider);
  return repository.getTagGroups();
}
