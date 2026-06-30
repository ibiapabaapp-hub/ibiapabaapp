import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ibivibe/shared/models/tag.dart';
import 'package:ibivibe/features/tags/models/tag_group_model.dart';

part 'tag_model.g.dart';

@JsonSerializable()
class TagModel extends Equatable implements Tag {
  @override
  final String id;
  @override
  final String name;
  @override
  final String slug;
  @override
  final String? description;
  @override
  final String? color;
  @override
  @JsonKey(name: 'group_id')
  final String groupId;
  @override
  @JsonKey(defaultValue: 0)
  final int position;
  @override
  final TagGroupModel? group;

  const TagModel({
    this.id = '',
    this.name = '',
    this.slug = '',
    this.description,
    this.color,
    required this.groupId,
    this.position = 0,
    this.group,
  });

  factory TagModel.fromJson(Map<String, dynamic> json) =>
      _$TagModelFromJson(json);

  Map<String, dynamic> toJson() => _$TagModelToJson(this);

  static List<TagModel> fromJsonList(List<dynamic>? jsonList) {
    if (jsonList == null) return [];
    return jsonList
        .whereType<Map<String, dynamic>>()
        .map((item) => TagModel.fromJson(item))
        .toList();
  }

  @override
  List<Object?> get props => [id, name, slug, description, color, groupId, position, group];
}
