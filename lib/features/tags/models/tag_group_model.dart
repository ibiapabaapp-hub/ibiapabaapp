import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ibivibe/shared/models/tag_group.dart';
import 'package:ibivibe/features/tags/models/tag_model.dart';

part 'tag_group_model.g.dart';

@JsonSerializable()
class TagGroupModel extends Equatable implements TagGroup {
  @override
  final String id;
  @override
  final String name;
  @override
  final String? description;
  @override
  final List<TagModel> tags;

  const TagGroupModel({
    this.id = '',
    this.name = '',
    this.description,
    this.tags = const [],
  });

  factory TagGroupModel.fromJson(Map<String, dynamic> json) =>
      _$TagGroupModelFromJson(json);

  Map<String, dynamic> toJson() => _$TagGroupModelToJson(this);

  static List<TagGroupModel> fromJsonList(List<dynamic>? jsonList) {
    if (jsonList == null) return [];
    return jsonList
        .whereType<Map<String, dynamic>>()
        .map((item) => TagGroupModel.fromJson(item))
        .toList();
  }

  @override
  List<Object?> get props => [id, name, description, tags];
}
