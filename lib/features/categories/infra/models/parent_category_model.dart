import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ibiapabaapp/features/categories/infra/models/category_count_model.dart';
import 'package:ibiapabaapp/features/categories/domain/entities/parent_category.dart';

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
    @JsonKey(name: '_count') required CategoryCountModel count,
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
      count: CategoryCountModel(
        cities: category.count.cities,
        companies: category.count.companies,
        events: category.count.events,
        children: category.count.children,
      ),
    ).toJson();
  }
}
