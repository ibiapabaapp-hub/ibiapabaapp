import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ibiapabaapp/core/entities/entity_type.dart';
import 'package:ibiapabaapp/shared/models/child_category.dart';

part 'child_category_model.g.dart';

@JsonSerializable()
class ChildCategoryModel extends Equatable implements ChildCategory {
  @override
  final String id;
  @override
  final String name;
  @override
  final List<EntityType> entities;

  const ChildCategoryModel({
    this.id = '',
    this.name = '',
    required this.entities,
  });

  factory ChildCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$ChildCategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChildCategoryModelToJson(this);

  static List<ChildCategory> fromJsonList(List<dynamic>? jsonList) {
    if (jsonList == null) return [];
    return jsonList
        .whereType<Map<String, dynamic>>()
        .map((item) => ChildCategoryModel.fromJson(item))
        .toList();
  }

  static Map<String, dynamic> toMap(ChildCategory category) {
    if (category is ChildCategoryModel) {
      return category.toJson();
    }
    return ChildCategoryModel(
      id: category.id,
      name: category.name,
      entities: category.entities,
    ).toJson();
  }

  @override
  List<Object?> get props => [id, name, entities];
}
