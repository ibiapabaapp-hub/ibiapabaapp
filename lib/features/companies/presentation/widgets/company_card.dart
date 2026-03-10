import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:ibiapabaapp/core/logger/logger.dart';
import 'package:ibiapabaapp/features/companies/domain/entities/company.dart';
import 'package:ibiapabaapp/shared/ui/fragments/media/content_media.dart';
import 'package:ibiapabaapp/shared/ui/fragments/media/sources.dart';
import 'package:ibiapabaapp/shared/ui/layout/entity_badge.dart';

class CompanyCard extends StatelessWidget {
  final Company company;
  const CompanyCard({super.key, required this.company});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: .start,
      crossAxisAlignment: .start,
      mainAxisSize: .min,
      spacing: 12,
      children: [
        GestureDetector(
          onTap: () => context.push('/app/companies/${company.id}'),
          child: SizedBox(
            height: 160,
            width: .infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Stack(
                children: [
                  getCompanyImage(
                    context: context,
                    coverImgUrl: company.coverImgUrl,
                  ),
                  Positioned(
                    top: 8,
                    left: 8,
                    child: EntityBadge(type: .company),
                  ),
                ],
              ),
            ),
          ),
        ),
        Text(
          company.name,
          style: context.theme.typography.base.copyWith(fontWeight: .w500),
        ),
        Wrap(
          runSpacing: 6,
          spacing: 6,
          children: [
            ...company.categories.map(
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

Widget getCompanyImage({
  required BuildContext context,
  String? coverImgUrl,
  Widget? fallback,
}) {
  final errorPlaceholder = fallback ?? _DefaultErrorPlaceholder(height: 160);

  if (coverImgUrl == null || coverImgUrl.isEmpty) {
    return errorPlaceholder;
  }

  logger.d(coverImgUrl);

  final source = NetworkMedia(url: coverImgUrl);

  return SizedBox(
    height: 160,
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
        Icons.business_center_outlined,
        size: 48,
        color: context.theme.colors.mutedForeground,
      ),
    );
  }
}
