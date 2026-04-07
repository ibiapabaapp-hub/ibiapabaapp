import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ibiapabaapp/features/companies/domain/entities/company.dart';
import 'package:ibiapabaapp/features/events/domain/entities/event.dart';

part 'event_model.freezed.dart';
part 'event_model.g.dart';

@freezed
abstract class EventModel with _$EventModel implements Event {
  const EventModel._();

  const factory EventModel({
    required String id,
    required String slug,
    required String name,
    String? userId,
    String? companyId,
    String? description,
    @JsonKey(unknownEnumValue: EventType.simple) required EventType type,
    required ReachLevel reachLevel,
    String? coverImgUrl,
    @Default([]) List<String> categories,
    required DateTime startDate,
    required DateTime endDate,
    required DateTime createdAt,
    required DateTime updatedAt,
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
      userId: event.userId,
      companyId: event.companyId,
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
