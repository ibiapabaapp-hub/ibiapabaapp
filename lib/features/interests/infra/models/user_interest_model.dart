import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ibiapabaapp/features/interests/domain/entities/user_interests.dart';

part 'user_interest_model.freezed.dart';
part 'user_interest_model.g.dart';

@freezed
abstract class UserInterestModel
    with _$UserInterestModel
    implements UserInterests {
  const UserInterestModel._();

  const factory UserInterestModel({
    @Default([]) List<String> companyIds,
    @Default([]) List<String> eventIds,
  }) = _UserInterestModel;

  factory UserInterestModel.fromJson(Map<String, dynamic> json) =>
      _$UserInterestModelFromJson(json);

  @override
  List<String> get categoriesIds => [...companyIds, ...eventIds];

  static Map<String, dynamic> toMap(UserInterests interest) {
    if (interest is UserInterestModel) return interest.toJson();
    return UserInterestModel(
      companyIds: interest.companyIds,
      eventIds: interest.eventIds,
    ).toJson();
  }

  static List<UserInterestModel> fromList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => UserInterestModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
