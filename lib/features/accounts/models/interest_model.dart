import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ibivibe/features/accounts/models/account_interests.dart';

part 'interest_model.g.dart';

@JsonSerializable()
class InterestModel extends Equatable implements Interest {
  @override
  final String id;

  @override
  final String name;

  const InterestModel({required this.id, required this.name});

  factory InterestModel.fromJson(Map<String, dynamic> json) =>
      _$InterestModelFromJson(json);

  Map<String, dynamic> toJson() => _$InterestModelToJson(this);

  static Map<String, dynamic> toMap(Interest interest) => {
    'id': interest.id,
    'name': interest.name,
  };

  @override
  List<Object?> get props => [id, name];
}
