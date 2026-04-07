import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ibiapabaapp/features/companies/domain/entities/company.dart';

part 'company_model.freezed.dart';
part 'company_model.g.dart';

@freezed
abstract class CompanyModel with _$CompanyModel implements Company {
  const CompanyModel._();

  const factory CompanyModel({
    @Default('') String id,
    @Default('') String slug,
    String? cnpj,
    @Default('') String name,
    String? description,
    @JsonKey(unknownEnumValue: ReachLevel.local)
    required ReachLevel maxReachLevel,
    String? coverImgUrl,
    @Default([]) List<String> categories,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _CompanyModel;

  factory CompanyModel.fromJson(Map<String, dynamic> json) =>
      _$CompanyModelFromJson(json);

  static List<Company> fromJsonList(dynamic jsonList) {
    if (jsonList == null) return [];
    return (jsonList as List<dynamic>)
        .map((json) => CompanyModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  static Map<String, dynamic> toMap(Company company) {
    if (company is CompanyModel) return company.toJson();
    return CompanyModel(
      id: company.id,
      name: company.name,
      cnpj: company.cnpj,
      slug: company.slug,
      coverImgUrl: company.coverImgUrl,
      maxReachLevel: company.maxReachLevel,
      description: company.description,
      categories: company.categories,
      createdAt: company.createdAt,
      updatedAt: company.updatedAt,
    ).toJson();
  }
}
