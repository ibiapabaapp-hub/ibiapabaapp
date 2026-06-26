import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ibiapabaapp/shared/models/business.dart';

part 'business_model.freezed.dart';
part 'business_model.g.dart';

@freezed
abstract class BusinessModel with _$BusinessModel implements Business {
  const BusinessModel._();

  const factory BusinessModel({
    @Default('') String id,
    @Default('')
    @JsonKey(defaultValue: '', name: 'profile_id')
    String profileId,
    @Default('') String slug,
    String? cnpj,
    @Default('') String name,
    String? bio,
    @JsonKey(name: 'avatar_url') String? avatar,

    @JsonKey(unknownEnumValue: ReachLevel.local, name: 'max_reach_level')
    required ReachLevel maxReachLevel,

    @JsonKey(name: 'cover_img_url') String? coverImgUrl,
    @Default([]) List<String> categories,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _BusinessModel;

  factory BusinessModel.fromJson(Map<String, dynamic> json) =>
      _$BusinessModelFromJson(json);

  static List<Business> fromJsonList(dynamic jsonList) {
    if (jsonList == null) return [];
    return (jsonList as List<dynamic>)
        .map((json) => BusinessModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  static Map<String, dynamic> toMap(Business business) {
    if (business is BusinessModel) return business.toJson();
    return BusinessModel(
      id: business.id,
      name: business.name,
      slug: business.slug,
      bio: business.bio,
      avatar: business.avatar,
      maxReachLevel: business.maxReachLevel,
      categories: business.categories,
      createdAt: business.createdAt,
    ).toJson();
  }
}
