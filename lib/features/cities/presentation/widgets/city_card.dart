import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:ibiapabaapp/features/cities/domain/entities/city.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CityCard extends StatelessWidget {
  final City city;
  const CityCard({super.key, required this.city});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: .start,
      crossAxisAlignment: .start,
      spacing: 12,
      children: [
        GestureDetector(
          onTap: () => context.push('app/cities/${city.id}'),
          child: SizedBox(
            height: 160,
            width: .infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Stack(
                children: [
                  getCityImage(context: context, coverImgUrl: city.coverImgUrl),
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: .all(4),
                      decoration: BoxDecoration(
                        borderRadius: .circular(6),
                        color: context.theme.colors.secondary,
                      ),
                      child: Icon(
                        Icons.location_city,
                        size: 18,
                        color: context.theme.colors.secondaryForeground,
                      ),
                    ),
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
          children: [
            ...city.categories.map(
              (cat) => FBadge(
                style: FBadgeStyle.secondary(),
                child: Text(
                  cat,
                  style: context.theme.typography.xs.copyWith(
                    fontWeight: .normal,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

Widget getCityImage({required BuildContext context, String? coverImgUrl}) {
  if (coverImgUrl == null) {
    return Container(
      color: context.theme.colors.muted,
      width: double.infinity,
      height: 160,
    );
  }

  return Image.network(
    coverImgUrl,
    height: 160,
    width: double.infinity,
    fit: BoxFit.cover,
    loadingBuilder: (context, child, loadingProgress) {
      if (loadingProgress != null) {
        return const Bone(
          width: double.infinity,
          height: 160,
          borderRadius: .all(.circular(8)),
        );
      }
      return child;
    },
    errorBuilder: (context, error, stackTrace) {
      return Container(
        color: context.theme.colors.muted,
        width: double.infinity,
        height: 160,
      );
    },
  );
}
