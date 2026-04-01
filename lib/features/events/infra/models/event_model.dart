import 'package:ibiapabaapp/features/companies/domain/entities/company.dart';
import 'package:ibiapabaapp/features/events/domain/entities/event.dart';

class EventModel {
  static Event fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      slug: json['slug'],
      name: json['name'],
      userId: json['user_id']?.toString(),
      companyId: json['company_id']?.toString(),

      description: json['description'] ?? '',
      coverImgUrl: json['cover_img_url'] ?? '',
      type: EventType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => EventType.simple,
      ),
      reachLevel: ReachLevel.values.firstWhere(
        (e) => e.name == json['reach_level'],
        orElse: () => ReachLevel.local,
      ),

      startDate: DateTime.parse(json['start_date'] as String),
      endDate: DateTime.parse(json['end_date'] as String),

      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),

      categories:
          (json['categories'] as List?)?.map((e) => e.toString()).toList() ??
          [],
    );
  }

  static Map<String, dynamic> toJson(Event event) {
    return {
      'id': event.id,
      'slug': event.slug,
      'name': event.name,
      'user_id': event.userId,
      'company_id': event.companyId,

      'description': event.description,
      'cover_img_url': event.coverImgUrl,
      'type': event.type.name,
      'reach_level': event.reachLevel.name,
      'categories': event.categories,

      'start_date': event.startDate.toIso8601String(),
      'end_date': event.endDate.toIso8601String(),

      'created_at': event.createdAt.toIso8601String(),
      'updated_at': event.updatedAt.toIso8601String(),
    };
  }

  static List<Event> fromJsonList(dynamic jsonList) {
    if (jsonList is! List) return [];
    return jsonList
        .map((json) => fromJson(Map<String, dynamic>.from(json as Map)))
        .toList();
  }
}
