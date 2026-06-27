import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ibiapabaapp/features/accounts/domain/entities/account_interests.dart';
import 'package:ibiapabaapp/features/accounts/infra/models/interest_model.dart';

part 'account_interests_model.g.dart';

@JsonSerializable()
class AccountInterestsModel extends Equatable implements AccountInterests {
  @override
  @JsonKey(name: 'businesses')
  final List<InterestModel> businesses;

  @override
  @JsonKey(name: 'events')
  final List<InterestModel> events;

  const AccountInterestsModel({
    this.businesses = const [],
    this.events = const [],
  });

  factory AccountInterestsModel.fromJson(Map<String, dynamic> json) =>
      _$AccountInterestsModelFromJson(json);

  Map<String, dynamic> toJson() => _$AccountInterestsModelToJson(this);

  static Map<String, dynamic> toMap(AccountInterests interests) {
    return {
      'businesses': interests.businesses
          .map(InterestModel.toMap)
          .toList(growable: false),
      'events': interests.events
          .map(InterestModel.toMap)
          .toList(growable: false),
    };
  }

  static AccountInterests toEntity(AccountInterestsModel model) {
    return AccountInterests(businesses: model.businesses, events: model.events);
  }

  @override
  List<Object?> get props => [businesses, events];
}
