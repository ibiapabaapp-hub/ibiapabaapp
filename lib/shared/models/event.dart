import 'business.dart';

enum EventType { simple, featured }

class Event {
  final String id;
  final String ownerAccountId;
  final String slug;
  final String name;

  final String? description;
  final EventType type;
  final ReachLevel reachLevel;
  final String? coverImgUrl;
  final List<String> tags;

  final DateTime startDate;
  final DateTime endDate;

  final DateTime createdAt;
  final DateTime updatedAt;

  Event({
    required this.id,
    required this.ownerAccountId,
    required this.slug,
    required this.name,
    this.description,
    required this.type,
    required this.reachLevel,
    this.coverImgUrl,
    required this.tags,

    required this.startDate,
    required this.endDate,

    required this.createdAt,
    required this.updatedAt,
  });
}
