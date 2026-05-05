import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:ibiapabaapp/features/businesses/domain/entities/business.dart';
import 'package:ibiapabaapp/shared/ui/fragments/media/content_media.dart';
import 'package:ibiapabaapp/shared/ui/fragments/media/sources.dart';
import 'package:ibiapabaapp/shared/ui/layout/entity_badge.dart';
import 'package:ibiapabaapp/shared/utils/get_entity_icon.dart';

class BusinessCard extends StatelessWidget {
  final Business business;
  const BusinessCard({super.key, required this.business});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: .start,
      crossAxisAlignment: .start,
      mainAxisSize: .min,
      spacing: 8,
      children: [
        GestureDetector(
          onTap: () => context.push('/app/businesses/${business.id}'),
          child: SizedBox(
            height: 140,
            width: .infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Stack(
                children: [
                  getBusinessImage(
                    context: context,
                    coverImgUrl: business.avatar,
                  ),
                  const Positioned(
                    top: 8,
                    left: 8,
                    child: EntityBadge(type: .business),
                  ),
                ],
              ),
            ),
          ),
        ),
        Text(
          business.name,
          style: context.theme.typography.base.copyWith(fontWeight: .w500),
          maxLines: 1,
          overflow: .ellipsis,
        ),
        Wrap(
          runSpacing: 6,
          spacing: 6,
          children: [
            ...business.categories
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
                .take(2),
          ],
        ),
      ],
    );
  }
}

Widget getBusinessImage({
  required BuildContext context,
  String? coverImgUrl,
  Widget? fallback,
}) {
  final errorPlaceholder =
      fallback ?? const _DefaultErrorPlaceholder(height: 160);

  if (coverImgUrl == null || coverImgUrl.isEmpty) {
    return errorPlaceholder;
  }

  final source = NetworkMedia(url: coverImgUrl);

  return SizedBox(
    height: 140,
    width: double.infinity,
    child: ContentMedia(
      source: source,
      fit: BoxFit.cover,
      errorWidget: errorPlaceholder,
    ),
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
        getEntityIcon(.business),
        size: 48,
        color: context.theme.colors.mutedForeground,
      ),
    );
  }
}
