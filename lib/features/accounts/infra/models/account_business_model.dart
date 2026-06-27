import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/account_business.dart';

part 'account_business_model.g.dart';

@JsonSerializable()
class AccountBusinessModel extends Equatable implements AccountBusiness {
  @override
  final String? name;

  @override
  final String? document;

  @override
  final String? description;

  @override
  final String? website;

  @override
  final String? address;

  @override
  final String? phone;

  @override
  final String? category;

  const AccountBusinessModel({
    this.name,
    this.document,
    this.description,
    this.website,
    this.address,
    this.phone,
    this.category,
  });

  factory AccountBusinessModel.fromJson(Map<String, dynamic> json) =>
      _$AccountBusinessModelFromJson(json);

  Map<String, dynamic> toJson() => _$AccountBusinessModelToJson(this);

  static Map<String, dynamic> toMap(AccountBusiness business) {
    if (business is AccountBusinessModel) return business.toJson();
    return AccountBusinessModel(
      name: business.name,
      document: business.document,
      description: business.description,
      website: business.website,
      address: business.address,
      phone: business.phone,
      category: business.category,
    ).toJson();
  }

  @override
  List<Object?> get props => [
    name,
    document,
    description,
    website,
    address,
    phone,
    category,
  ];
}
