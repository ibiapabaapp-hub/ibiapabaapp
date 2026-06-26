import 'package:equatable/equatable.dart';
import 'package:ibiapabaapp/features/favorites/domain/entities/favorite.dart';

class FavoriteModel extends Equatable implements Favorite {
  @override
  final String? id;
  @override
  final String accountId;
  @override
  final String? cityId;
  @override
  final String? businessId;
  @override
  final String? eventId;

  const FavoriteModel({
    this.id,
    required this.accountId,
    this.cityId,
    this.businessId,
    this.eventId,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      id: json['id'] as String?,
      accountId: json['account_id'] as String,
      cityId: json['city_id'] as String?,
      businessId: json['business_id'] as String?,
      eventId: json['event_id'] as String?,
    );
  }

  static List<Favorite> fromJsonList(dynamic jsonList) {
    if (jsonList == null) return [];
    return (jsonList as List<dynamic>)
        .map((json) => FavoriteModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  static Map<String, dynamic> toMap(Favorite favorite) {
    return {
      'id': favorite.id,
      'account_id': favorite.accountId,
      'city_id': favorite.cityId,
      'business_id': favorite.businessId,
      'event_id': favorite.eventId,
    };
  }

  static Map<String, dynamic> mapPush(Favorite favorite) {
    return {
      'account_id': favorite.accountId,
      'city_id': favorite.cityId,
      'business_id': favorite.businessId,
      'event_id': favorite.eventId,
    };
  }

  @override
  List<Object?> get props => [id, accountId, cityId, businessId, eventId];
}
