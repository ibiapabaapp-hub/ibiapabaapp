import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:ibivibe/core/entities/entity_type.dart';
import 'package:ibivibe/features/search/domain/entities/search_result.dart';
import 'package:ibivibe/shared/ui/layout/entity_badge.dart';

class SearchItem extends StatelessWidget {
  final SearchResult result;

  const SearchItem({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final String title;
    final String? subtitle;
    final String? imageUrl;
    final EntityType type;

    switch (result) {
      case CitySearchResult(:final city):
        title = city.name;
        subtitle = city.description;
        imageUrl = city.coverImgUrl;
        type = EntityType.city;
      case BusinessSearchResult(:final business):
        title = business.name;
        subtitle = business.bio;
        imageUrl = business.avatar;
        type = EntityType.business;
      case EventSearchResult(:final event):
        title = event.name;
        subtitle = event.description;
        imageUrl = event.coverImgUrl;
        type = EntityType.event;
    }

    return InkWell(
      onTap: () => _handleTap(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          spacing: 16,
          children: [
            _buildLeading(context, imageUrl, type),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.theme.typography.base.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (subtitle != null && subtitle.isNotEmpty)
                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.theme.typography.sm.copyWith(
                        color: context.theme.colors.mutedForeground,
                      ),
                    ),
                ],
              ),
            ),
            EntityBadge(type: type, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildLeading(BuildContext context, String? url, EntityType type) {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: context.theme.colors.muted,
        image: url != null && url.isNotEmpty
            ? DecorationImage(image: NetworkImage(url), fit: BoxFit.cover)
            : null,
      ),
      child: url == null || url.isEmpty
          ? Icon(
              Icons.image,
              color: context.theme.colors.mutedForeground,
              size: 24,
            )
          : null,
    );
  }

  void _handleTap(BuildContext context) {
    switch (result) {
      case CitySearchResult(:final city):
        context.push('/app/cities/${city.id}');
      case BusinessSearchResult(:final business):
        context.push('/app/businesses/${business.id}');
      case EventSearchResult(:final event):
        context.push('/app/events/${event.id}');
    }
  }
}
