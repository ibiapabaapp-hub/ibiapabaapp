import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ibiapabaapp/features/interests/domain/entities/user_interest_count.dart';

part 'user_interests_count_model.freezed.dart';
part 'user_interests_count_model.g.dart';

@freezed
abstract class UserInterestsCountModel with _$UserInterestsCountModel implements UserInterestCount {
  const UserInterestsCountModel._();

  const factory UserInterestsCountModel({
    required int count,
  }) = _UserInterestsCountModel;

  factory UserInterestsCountModel.fromJson(Map<String, dynamic> json) =>
      _$UserInterestsCountModelFromJson(json);

  static List<UserInterestsCountModel> fromList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => UserInterestsCountModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}