import 'package:flutter/material.dart';
import 'package:ibivibe/core/entities/entity_type.dart';

IconData getEntityIcon(EntityType type) {
  switch (type) {
    case EntityType.city:
      return Icons.pin_drop_rounded;
    case EntityType.business:
      return Icons.store_rounded;
    case EntityType.event:
      return Icons.event_rounded;
  }
}
