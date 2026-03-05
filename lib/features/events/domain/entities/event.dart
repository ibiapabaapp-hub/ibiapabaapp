enum EventType { simple, featured }

enum EventReachLevel { local, regional }

class Event {
  final String id;
  final String slug;
  final String name;
  final EventType type;
  final EventReachLevel reachLevel;
  final String? userId;
  final String? companyId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Event({
    required this.id,
    required this.slug,
    required this.name,
    required this.type,
    required this.reachLevel,
    this.userId,
    this.companyId,
    required this.createdAt,
    required this.updatedAt,
  });
}
