import 'package:ibivibe/shared/models/tag_group.dart';

abstract class TagsRepository {
  Future<List<TagGroup>> getTagGroups();
}
