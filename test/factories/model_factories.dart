import 'package:ibivibe/shared/models/account.dart';
import 'package:ibivibe/shared/models/account_type.dart';
import 'package:ibivibe/shared/models/business.dart';
import 'package:ibivibe/shared/models/city.dart';
import 'package:ibivibe/shared/models/event.dart';
import 'package:ibivibe/shared/models/gender.dart';
import 'package:ibivibe/shared/models/tag_group.dart';
import 'package:ibivibe/shared/models/tag.dart';
import 'package:ibivibe/features/auth/models/auth_result.dart';
import 'package:ibivibe/features/favorites/models/favorite.dart';
import 'package:ibivibe/features/accounts/models/account_interests.dart';
import 'package:ibivibe/features/accounts/models/account_business.dart';

Account makeAccount({
  String? id,
  String? email,
  String? name,
  String? slug,
  String? displayName,
  AccountType type = AccountType.personal,
  bool active = true,
  bool isVerified = true,
  Gender? gender,
  AccountInterests? interests,
  AccountBusiness? business,
}) {
  final now = DateTime(2025, 1, 1);
  return Account(
    id: id ?? 'test-id',
    email: email ?? 'test@example.com',
    name: name ?? 'Test User',
    slug: slug ?? 'test-user',
    displayName: displayName ?? 'Test User',
    type: type,
    active: active,
    isVerified: isVerified,
    createdAt: now,
    updatedAt: now,
    gender: gender,
    interests: interests,
    business: business,
  );
}

Event makeEvent({
  String? id,
  String? ownerAccountId,
  String? slug,
  String? name,
  EventType type = EventType.simple,
  ReachLevel reachLevel = ReachLevel.local,
  List<String>? tags,
  DateTime? startDate,
  DateTime? endDate,
}) {
  final now = DateTime(2025, 1, 1);
  return Event(
    id: id ?? 'test-event-id',
    ownerAccountId: ownerAccountId ?? 'test-owner-id',
    slug: slug ?? 'test-event',
    name: name ?? 'Test Event',
    type: type,
    reachLevel: reachLevel,
    tags: tags ?? ['rock'],
    startDate: startDate ?? now.add(const Duration(days: 7)),
    endDate: endDate ?? now.add(const Duration(days: 8)),
    createdAt: now,
    updatedAt: now,
  );
}

City makeCity({
  String? id,
  String? name,
  String? slug,
  List<String>? tags,
}) {
  return City(
    id: id ?? 'test-city-id',
    name: name ?? 'Test City',
    slug: slug ?? 'test-city',
    tags: tags ?? ['praia'],
  );
}

Business makeBusiness({
  String? id,
  String? name,
  String? slug,
  ReachLevel maxReachLevel = ReachLevel.local,
  List<String>? tags,
  DateTime? createdAt,
}) {
  return Business(
    id: id ?? 'test-business-id',
    name: name ?? 'Test Business',
    slug: slug ?? 'test-business',
    maxReachLevel: maxReachLevel,
    tags: tags ?? ['restaurante'],
    createdAt: createdAt ?? DateTime(2025, 1, 1),
  );
}

AuthResult makeAuthResult({
  String? accessToken,
  String? refreshToken,
  Account? account,
}) {
  return AuthResult(
    accessToken: accessToken ?? 'test-access-token',
    refreshToken: refreshToken ?? 'test-refresh-token',
    account: account ?? makeAccount(),
  );
}

Favorite makeFavorite({
  String? id,
  String? accountId,
  String? cityId,
  String? eventId,
  String? businessId,
}) {
  return Favorite(
    id: id ?? 'test-favorite-id',
    accountId: accountId ?? 'test-account-id',
    cityId: cityId,
    eventId: eventId,
    businessId: businessId,
  );
}

TagGroup makeTagGroup({
  String? id,
  String? name,
  String? description,
}) {
  return TagGroup(
    id: id ?? 'test-tag-group-id',
    name: name ?? 'Test Tag Group',
    description: description,
  );
}

Tag makeTag({
  String? id,
  String? name,
  String? slug,
  String? color,
  String? groupId,
  int position = 0,
}) {
  return Tag(
    id: id ?? 'test-tag-id',
    name: name ?? 'Test Tag',
    slug: slug ?? 'test-tag',
    color: color,
    groupId: groupId ?? 'test-tag-group-id',
    position: position,
  );
}
