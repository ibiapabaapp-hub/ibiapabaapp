import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ibiapabaapp/core/entities/entity_type.dart';
import 'package:ibiapabaapp/shared/models/parent_category.dart';
import 'package:ibiapabaapp/features/categories/infra/models/child_category_model.dart';

part 'parent_category_model.g.dart';

@JsonSerializable()
class ParentCategoryModel extends Equatable implements ParentCategory {
  @override
  final String id;
  @override
  final String name;
  @override
  final List<EntityType> entities;
  @override
  final List<ChildCategoryModel>? children;

  const ParentCategoryModel({
    this.id = '',
    this.name = '',
    required this.entities,
    this.children,
  });

  factory ParentCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$ParentCategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$ParentCategoryModelToJson(this);

  static List<ParentCategory> fromJsonList(List<dynamic>? jsonList) {
    if (jsonList == null) return [];
    return jsonList
        .whereType<Map<String, dynamic>>()
        .map((item) => ParentCategoryModel.fromJson(item))
        .toList();
  }

  static Map<String, dynamic> toMap(ParentCategory category) {
    if (category is ParentCategoryModel) {
      return category.toJson();
    }
    return ParentCategoryModel(
      id: category.id,
      name: category.name,
      entities: category.entities,
      children: category.children
          ?.map(
            (child) => child is ChildCategoryModel
                ? child
                : ChildCategoryModel(
                    id: child.id,
                    name: child.name,
                    entities: child.entities,
                  ),
          )
          .toList(),
    ).toJson();
  }

  @override
  List<Object?> get props => [id, name, entities, children];
}
