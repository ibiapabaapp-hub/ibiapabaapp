import 'package:ibiapabaapp/features/companies/domain/entities/company.dart';

class CompanyModel {
  static Company fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['id'].toString(),
      name: json['name'],
      slug: json['slug'],
      cnpj: json['cnpj'] ?? '',
      maxReachLevel: ReachLevel.values.firstWhere(
        (e) => e.name == json['max_reach_level'],
        orElse: () => ReachLevel.local,
      ),
      coverImgUrl: json['cover_img_url'] ?? '',
      description: json['description'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      categories:
          (json['categories'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
    );
  }

  static List<Company> fromJsonList(dynamic jsonList) {
    if (jsonList == null) return [];
    final list = jsonList as List<dynamic>;
    return list.map((json) => fromJson(json as Map<String, dynamic>)).toList();
  }

  static Map<String, dynamic> toMap(Company company) {
    return {
      'id': company.id,
      'name': company.name,
      'cnpj': company.cnpj,
      'slug': company.slug,
      'cover_img_url': company.coverImgUrl,
      'max_reach_level': company.maxReachLevel.name,
      'description': company.description,
      'categories': company.categories,
    };
  }
}
