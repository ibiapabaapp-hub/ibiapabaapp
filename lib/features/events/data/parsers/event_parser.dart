import 'package:ibiapabaapp/features/events/domain/entities/event.dart';

class EventParser {
  static Event fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'] as String,
      slug: json['id'] as String,
      name: json['id'] as String,
      type: json['type'] as EventType,
      reachLevel: json['reach_level'],
      userId: json['user_id'] as String,
      companyId: json['company_id'] as String,
      createdAt: json['created_at'] as DateTime,
      updatedAt: json['updated_at'] as DateTime,
    );
  }

  Map<String, dynamic> toJson(Event event) {
    return {
      'id': event.id,
      'slug': event.slug,
      'name': event.name,
      'type': event.type,
      'reach_level': event.reachLevel,
      'user_id': event.userId,
      'company_id': event.companyId,
      'created_at': event.createdAt.toIso8601String(),
      'updated_at': event.updatedAt.toIso8601String(),
    };
  }
}
