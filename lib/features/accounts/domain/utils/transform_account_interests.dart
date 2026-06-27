import 'package:ibivibe/features/accounts/domain/entities/account_interests.dart';

List<String> getInterestsIdsList(AccountInterests interests) => [
  ...interests.businesses.map((e) => e.id),
  ...interests.events.map((e) => e.id),
];

List<String> getInterestsNamesList(AccountInterests interests) => [
  ...interests.businesses.map((e) => e.name),
  ...interests.events.map((e) => e.name),
];

Set<String> getInterestsIdsSet(AccountInterests interests) => {
  ...interests.businesses.map((e) => e.id),
  ...interests.events.map((e) => e.id),
};
