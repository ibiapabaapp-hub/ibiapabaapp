import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:ibivibe/shared/models/event.dart';
import 'package:ibivibe/shared/ui/fragments/media/content_media.dart';
import 'package:ibivibe/shared/ui/fragments/media/sources.dart';
import 'package:ibivibe/shared/ui/layout/entity_badge.dart';
import 'package:ibivibe/shared/utils/get_entity_icon.dart';

class EventCard extends StatelessWidget {
  final Event event;

  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/app/events/${event.id}'),
      child: FCard(
        style: (style) => style.copyWith(
          contentStyle: (s) => s.copyWith(padding: const EdgeInsets.all(12)),
          decoration: style.decoration.copyWith(
            border: Border.all(width: 0, color: Colors.transparent),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 6,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8,
              children: [
                SizedBox(
                  width: 70,
                  height: 70,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Stack(
                      children: [
                        _getEventImage(
                          context: context,
                          coverImgUrl: event.coverImgUrl,
                        ),
                        const Positioned(
                          top: 4,
                          left: 4,
                          child: EntityBadge(type: .event),
                        ),
                      ],
                    ),
                  ),
                ),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 4,
                    children: [
                      Text(
                        event.name,
                        style: context.theme.typography.sm.copyWith(
                          fontWeight: .w500,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),

                      Text(
                        '${_getFormattedDDMM(event.startDate)} - ${_getFormattedDDMM(event.endDate)}',
                        style: context.theme.typography.xs.copyWith(
                          color: context.theme.colors.mutedForeground,
                        ),
                      ),

                      LayoutBuilder(
                        builder: (context, constraints) {
                          final availableWidth = constraints.maxWidth;
                          final badgeWidth = 60.0; // Estimated badge width
                          final spacing = 4.0;
                          final maxBadges =
                              (availableWidth + spacing) ~/
                              (badgeWidth + spacing);

                          final badges = <Widget>[
                            _buildBadge(context, 'Evento'),
                          ];

                          if (event.categories.isNotEmpty) {
                            final categoryBadges = event.categories
                                .take(2)
                                .map((cat) => _buildBadge(context, cat))
                                .toList();

                            final remainingSlots = maxBadges - 1;
                            if (remainingSlots > 0) {
                              badges.addAll(
                                categoryBadges.take(remainingSlots),
                              );
                            }
                          } else {
                            if (maxBadges > 1) {
                              badges.add(_buildBadge(context, 'Esportivo'));
                            }
                          }

                          return Wrap(
                            runSpacing: 4,
                            spacing: 4,
                            children: badges,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getFormattedDDMM(DateTime date) {
    return UtilData.obterDataDDMM(date);
  }

  Widget _buildBadge(BuildContext context, String text) {
    return FBadge(
      style: FBadgeStyle.secondary(),
      child: Text(
        text,
        style: context.theme.typography.xs.copyWith(fontWeight: .normal),
      ),
    );
  }

  Widget _getEventImage({
    required BuildContext context,
    String? coverImgUrl = '',
  }) {
    final theme = context.theme;
    return ContentMedia(
      source: NetworkMedia(url: coverImgUrl ?? ''),
      fit: BoxFit.cover,
      errorWidget: Container(
        color: theme.colors.muted,
        child: Icon(
          getEntityIcon(.event),
          color: theme.colors.mutedForeground,
          size: 48,
        ),
      ),
    );
  }
}
