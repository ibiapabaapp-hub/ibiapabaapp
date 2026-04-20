import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:ibiapabaapp/core/entities/entity_type.dart';
import 'package:ibiapabaapp/features/cities/domain/entities/city.dart';
import 'package:ibiapabaapp/shared/ui/fragments/media/content_media.dart';
import 'package:ibiapabaapp/shared/ui/fragments/media/sources.dart';
import 'package:ibiapabaapp/shared/ui/layout/entity_badge.dart';
import 'package:ibiapabaapp/shared/utils/get_entity_icon.dart';

class CityCard extends StatelessWidget {
  final City city;
  const CityCard({super.key, required this.city});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: .start,
      crossAxisAlignment: .start,
      spacing: 8,
      children: [
        GestureDetector(
          onTap: () => context.push('/app/cities/${city.id}'),
          child: SizedBox(
            height: 140,
            width: .infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Stack(
                children: [
                  getCityImage(context: context, coverImgUrl: city.coverImgUrl),
                  Positioned(
                    top: 8,
                    left: 8,
                    child: EntityBadge(type: EntityType.city),
                  ),
                ],
              ),
            ),
          ),
        ),

        Text(
          city.name,
          style: context.theme.typography.base.copyWith(fontWeight: .w500),
        ),

        Wrap(
          runSpacing: 6,
          spacing: 6,
          clipBehavior: .hardEdge,
          children: [
            ...city.categories
                .map(
                  (cat) => FBadge(
                    style: FBadgeStyle.secondary(),
                    child: Text(
                      cat,
                      style: context.theme.typography.xs.copyWith(
                        fontWeight: .normal,
                      ),
                    ),
                  ),
                )
                .take(3),
          ],
        ),
      ],
    );
  }
}

Widget getCityImage({
  required BuildContext context,
  String? coverImgUrl,
  Widget? fallback,
}) {
  final errorPlaceholder =
      fallback ?? const _DefaultErrorPlaceholder(height: 160);

  if (coverImgUrl == null ||
      coverImgUrl.isEmpty ||
      !coverImgUrl.startsWith('http')) {
    return errorPlaceholder;
  }

  return ContentMedia(
    source: NetworkMedia(url: coverImgUrl),
    fit: BoxFit.cover,
    errorWidget: errorPlaceholder,
  );
}

class _DefaultErrorPlaceholder extends StatelessWidget {
  final double height;
  const _DefaultErrorPlaceholder({required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: context.theme.colors.muted,
      ),
      width: double.infinity,
      height: height,
      child: Icon(
        getEntityIcon(EntityType.city),
        size: 48,
        color: context.theme.colors.mutedForeground,
      ),
    );
  }
}
