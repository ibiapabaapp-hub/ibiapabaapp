import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ibiapabaapp/core/entities/entity_type.dart';
import 'package:ibiapabaapp/shared/models/child_category.dart';

part 'child_category_model.freezed.dart';
part 'child_category_model.g.dart';

@freezed
abstract class ChildCategoryModel
    with _$ChildCategoryModel
    implements ChildCategory {
  const ChildCategoryModel._();

  const factory ChildCategoryModel({
    @Default('') String id,
    @Default('') String name,
    required List<EntityType> entities,
  }) = _ChildCategoryModel;

  factory ChildCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$ChildCategoryModelFromJson(json);

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
}
