import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ibiapabaapp/shared/models/business.dart';
import 'package:ibiapabaapp/shared/models/event.dart';

part 'event_model.g.dart';

@JsonSerializable()
class EventModel extends Equatable implements Event {
  @override
  final String id;
  @override
  final String slug;
  @override
  final String name;
  @override
  @JsonKey(name: 'owner_account_id')
  final String ownerAccountId;
  @override
  final String? description;
  @override
  @JsonKey(unknownEnumValue: EventType.simple)
  final EventType type;
  @override
  @JsonKey(unknownEnumValue: ReachLevel.local, name: 'reach_level')
  final ReachLevel reachLevel;
  @override
  @JsonKey(name: 'cover_img_url')
  final String? coverImgUrl;
  @override
  final List<String> categories;
  @override
  @JsonKey(name: 'start_date')
  final DateTime startDate;
  @override
  @JsonKey(name: 'end_date')
  final DateTime endDate;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  const EventModel({
    required this.id,
    required this.slug,
    required this.name,
    required this.ownerAccountId,
    this.description,
    required this.type,
    required this.reachLevel,
    this.coverImgUrl,
    this.categories = const [],
    required this.startDate,
    required this.endDate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) =>
      _$EventModelFromJson(json);

  Map<String, dynamic> toJson() => _$EventModelToJson(this);

  static List<Event> fromJsonList(dynamic jsonList) {
    if (jsonList is! List) return [];
    return jsonList
        .map(
          (json) => EventModel.fromJson(Map<String, dynamic>.from(json as Map)),
        )
        .toList();
  }

  static Map<String, dynamic> toMap(Event event) {
    if (event is EventModel) return event.toJson();
    return EventModel(
      id: event.id,
      slug: event.slug,
      name: event.name,
      ownerAccountId: event.ownerAccountId,
      description: event.description,
      type: event.type,
      reachLevel: event.reachLevel,
      coverImgUrl: event.coverImgUrl,
      categories: event.categories,
      startDate: event.startDate,
      endDate: event.endDate,
      createdAt: event.createdAt,
      updatedAt: event.updatedAt,
    ).toJson();
  }

  @override
  List<Object?> get props => [
        id,
        slug,
        name,
        ownerAccountId,
        description,
        type,
        reachLevel,
        coverImgUrl,
        categories,
        startDate,
        endDate,
        createdAt,
        updatedAt,
      ];
}
