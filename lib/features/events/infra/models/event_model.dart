import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ibiapabaapp/shared/models/business.dart';
import 'package:ibiapabaapp/shared/models/event.dart';

part 'event_model.freezed.dart';
part 'event_model.g.dart';

@freezed
abstract class EventModel with _$EventModel implements Event {
  const EventModel._();

  const factory EventModel({
    required String id,
    required String slug,
    required String name,
    @JsonKey(name: 'owner_account_id') required String ownerAccountId,
    String? description,

    @JsonKey(unknownEnumValue: EventType.simple) required EventType type,
    @JsonKey(unknownEnumValue: ReachLevel.local, name: 'reach_level')
    required ReachLevel reachLevel,
    @JsonKey(name: 'cover_img_url') String? coverImgUrl,
    @Default([]) List<String> categories,
    @JsonKey(name: 'start_date') required DateTime startDate,
    @JsonKey(name: 'end_date') required DateTime endDate,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _EventModel;

  factory EventModel.fromJson(Map<String, dynamic> json) =>
      _$EventModelFromJson(json);

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
}
