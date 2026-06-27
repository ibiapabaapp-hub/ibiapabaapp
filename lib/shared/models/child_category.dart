import 'package:ibiapabaapp/core/entities/entity_type.dart';

class ChildCategory {
  final String id;
  final String name;
  final List<EntityType> entities;

  const ChildCategory({
    required this.id,
    required this.name,
    required this.entities,
  });
}
