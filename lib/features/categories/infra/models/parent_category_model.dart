import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ibiapabaapp/core/entities/entity_type.dart';
import 'package:ibiapabaapp/shared/models/parent_category.dart';
import 'package:ibiapabaapp/features/categories/infra/models/child_category_model.dart';

part 'parent_category_model.freezed.dart';
part 'parent_category_model.g.dart';

@freezed
abstract class ParentCategoryModel
    with _$ParentCategoryModel
    implements ParentCategory {
  const ParentCategoryModel._();

  const factory ParentCategoryModel({
    @Default('') String id,
    @Default('') String name,
    required List<EntityType> entities,
    @Default(null) List<ChildCategoryModel>? children,
  }) = _ParentCategoryModel;

  factory ParentCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$ParentCategoryModelFromJson(json);

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
}
