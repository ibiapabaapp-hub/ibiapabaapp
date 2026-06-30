import 'package:ibivibe/shared/models/tag.dart';

class TagGroup {
  final String id;
  final String name;
  final String? description;
  final List<Tag> tags;

  const TagGroup({
    required this.id,
    required this.name,
    this.description,
    this.tags = const [],
  });
}
