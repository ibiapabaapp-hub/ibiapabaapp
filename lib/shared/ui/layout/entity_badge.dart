import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:ibiapabaapp/features/medias/domain/entity/media.dart';
import 'package:skeletonizer/skeletonizer.dart';

class EntityBadge extends StatelessWidget {
  final EntityType type;
  const EntityBadge({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Skeleton.ignore(
      ignore: true,
      child: Container(
        padding: .all(4),
        decoration: BoxDecoration(
          borderRadius: .circular(6),
          color: context.theme.colors.background,
        ),
        child: Icon(
          _getEntityIcon(type),
          size: 18,
          color: context.theme.colors.foreground,
        ),
      ),
    );
  }

  IconData _getEntityIcon(EntityType type) {
    switch (type) {
      case EntityType.city:
        return Icons.location_city;
      case EntityType.company:
        return Icons.business_center_outlined;
      case EntityType.event:
        return Icons.event_rounded;
    }
  }
}
