import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ibiapabaapp/features/categories/domain/entities/category_count.dart';

part 'category_count_model.freezed.dart';
part 'category_count_model.g.dart';

@freezed
abstract class CategoryCountModel
    with _$CategoryCountModel
    implements CategoryCount {
  const factory CategoryCountModel({
    @JsonKey(name: 'city') required int cities,
    @JsonKey(name: 'company_category') required int companies,
    @JsonKey(name: 'event_category') required int events,
    required int children,
  }) = _CategoryCountModel;

  factory CategoryCountModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryCountModelFromJson(json);
}
