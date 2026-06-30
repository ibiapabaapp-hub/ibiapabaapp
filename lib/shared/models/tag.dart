import 'tag_group.dart';

class Tag {
  final String id;
  final String name;
  final String slug;
  final String? description;
  final String? color;
  final String groupId;
  final int position;
  final TagGroup? group;

  const Tag({
    required this.id,
    required this.name,
    required this.slug,
    this.description,
    this.color,
    required this.groupId,
    this.position = 0,
    this.group,
  });
}
