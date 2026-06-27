import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:ibiapabaapp/core/entities/entity_type.dart';
import 'package:ibiapabaapp/shared/utils/get_entity_icon.dart';
import 'package:skeletonizer/skeletonizer.dart';

class EntityBadge extends StatelessWidget {
  final double? size;
  final EntityType type;
  const EntityBadge({super.key, required this.type, this.size = 18});

  @override
  Widget build(BuildContext context) {
    return Skeleton.ignore(
      ignore: true,
      child: FBadge(
        style: FBadgeStyle.secondary(
          (style) => style.copyWith(
            contentStyle: (contentStyle) =>
                contentStyle.copyWith(padding: const EdgeInsets.all(4)),
            decoration: style.decoration.copyWith(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ),
        child: Icon(
          getEntityIcon(type),
          size: size,
          color: context.theme.colors.foreground,
        ),
      ),
    );
  }
}
