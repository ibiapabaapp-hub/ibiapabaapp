import 'package:ibivibe/shared/models/account.dart';
import 'package:ibivibe/shared/models/account_type.dart';
import 'package:ibivibe/shared/models/business.dart';
import 'package:ibivibe/shared/models/city.dart';
import 'package:ibivibe/shared/models/event.dart';
import 'package:ibivibe/shared/models/gender.dart';
import 'package:ibivibe/shared/models/parent_category.dart';
import 'package:ibivibe/shared/models/child_category.dart';
import 'package:ibivibe/features/auth/models/auth_result.dart';
import 'package:ibivibe/features/favorites/models/favorite.dart';
import 'package:ibivibe/features/accounts/models/account_interests.dart';
import 'package:ibivibe/features/accounts/models/account_business.dart';
import 'package:ibivibe/core/entities/entity_type.dart';

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
  List<String>? categories,
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
    categories: categories ?? ['music'],
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
  List<String>? categories,
}) {
  return City(
    id: id ?? 'test-city-id',
    name: name ?? 'Test City',
    slug: slug ?? 'test-city',
    categories: categories ?? ['tourism'],
  );
}

Business makeBusiness({
  String? id,
  String? name,
  String? slug,
  ReachLevel maxReachLevel = ReachLevel.local,
  List<String>? categories,
  DateTime? createdAt,
}) {
  return Business(
    id: id ?? 'test-business-id',
    name: name ?? 'Test Business',
    slug: slug ?? 'test-business',
    maxReachLevel: maxReachLevel,
    categories: categories ?? ['food'],
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

ParentCategory makeParentCategory({
  String? id,
  String? name,
  List<EntityType>? entities,
  List<ChildCategory>? children,
}) {
  return ParentCategory(
    id: id ?? 'test-category-id',
    name: name ?? 'Test Category',
    entities: entities ?? [EntityType.city],
    children: children,
  );
}

ChildCategory makeChildCategory({
  String? id,
  String? name,
  List<EntityType>? entities,
}) {
  return ChildCategory(
    id: id ?? 'test-child-category-id',
    name: name ?? 'Test Child Category',
    entities: entities ?? [EntityType.city],
  );
}
