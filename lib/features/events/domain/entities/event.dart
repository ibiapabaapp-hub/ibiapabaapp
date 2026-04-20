import 'package:ibiapabaapp/features/businesses/domain/entities/business.dart';

enum EventType { simple, featured }

class Event {
  final String id;
  final String slug;
  final String name;
  final String? userId;
  final String? companyId;

  final String? description;
  final EventType type;
  final ReachLevel reachLevel;
  final String? coverImgUrl;
  final List<String> categories;

  final DateTime startDate;
  final DateTime endDate;

  final DateTime createdAt;
  final DateTime updatedAt;

  Event({
    required this.id,
    required this.slug,
    required this.name,
    this.userId,
    this.companyId,

    this.description,
    required this.type,
    required this.reachLevel,
    this.coverImgUrl,
    required this.categories,

    required this.startDate,
    required this.endDate,

    required this.createdAt,
    required this.updatedAt,
  });
}
