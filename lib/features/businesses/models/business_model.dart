import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ibivibe/shared/models/business.dart';

part 'business_model.g.dart';

@JsonSerializable()
class BusinessModel extends Equatable implements Business {
  @override
  final String id;
  @JsonKey(defaultValue: '', name: 'profile_id')
  final String profileId;
  @override
  final String slug;
  final String? cnpj;
  @override
  final String name;
  @override
  final String? bio;
  @override
  @JsonKey(name: 'avatar_url')
  final String? avatar;
  @override
  @JsonKey(unknownEnumValue: ReachLevel.local, name: 'max_reach_level')
  final ReachLevel maxReachLevel;
  @JsonKey(name: 'cover_img_url')
  final String? coverImgUrl;
  @override
  final List<String> categories;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  const BusinessModel({
    this.id = '',
    this.profileId = '',
    this.slug = '',
    this.cnpj,
    this.name = '',
    this.bio,
    this.avatar,
    required this.maxReachLevel,
    this.coverImgUrl,
    this.categories = const [],
    required this.createdAt,
  });

  factory BusinessModel.fromJson(Map<String, dynamic> json) =>
      _$BusinessModelFromJson(json);

  Map<String, dynamic> toJson() => _$BusinessModelToJson(this);

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

  @override
  List<Object?> get props => [
        id,
        profileId,
        slug,
        cnpj,
        name,
        bio,
        avatar,
        maxReachLevel,
        coverImgUrl,
        categories,
        createdAt,
      ];
}
