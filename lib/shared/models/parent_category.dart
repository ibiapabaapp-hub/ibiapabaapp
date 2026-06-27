import 'package:ibivibe/core/entities/entity_type.dart';
import 'child_category.dart';

class ParentCategory {
  final String id;
  final String name;
  final List<EntityType> entities;
  final List<ChildCategory>? children;

  const ParentCategory({
    required this.id,
    required this.name,
    required this.entities,
    this.children,
  });
}
