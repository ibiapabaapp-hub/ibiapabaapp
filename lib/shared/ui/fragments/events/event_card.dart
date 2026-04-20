import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:ibiapabaapp/features/events/domain/entities/event.dart';
import 'package:ibiapabaapp/shared/ui/fragments/media/content_media.dart';
import 'package:ibiapabaapp/shared/ui/fragments/media/sources.dart';
import 'package:ibiapabaapp/shared/ui/layout/entity_badge.dart';
import 'package:ibiapabaapp/shared/utils/get_entity_icon.dart';

class EventCard extends StatelessWidget {
  final Event event;

  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final typography = theme.typography;

    return FCard(
      style: (style) => style.copyWith(
        contentStyle: (s) => s.copyWith(padding: EdgeInsets.all(6)),
        decoration: style.decoration.copyWith(
          border: Border.all(width: 0, color: Colors.transparent),
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: GestureDetector(
        onTap: () => context.push('/app/events/${event.id}'),
        child: Row(
          mainAxisSize: .min,
          crossAxisAlignment: .center,
          spacing: 16,
          children: [
            SizedBox(
              width: 120,
              height: 120,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Stack(
                  children: [
                    _getEventImage(
                      theme: context.theme,
                      context: context,
                      coverImgUrl: event.coverImgUrl,
                    ),
                    Positioned(
                      top: 8,
                      left: 8,
                      child: EntityBadge(type: .event),
                    ),
                  ],
                ),
              ),
            ),

            Flexible(
              child: Padding(
                padding: const .fromLTRB(0, 0, 8, 0),
                child: Column(
                  spacing: 2,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: typography.base.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${_getFormattedDDMM(event.startDate)} até ${_getFormattedDDMM(event.endDate)}',
                      style: typography.sm.copyWith(
                        color: theme.colors.mutedForeground,
                      ),
                    ),
                    const SizedBox(height: 8),

                    Wrap(
                      runSpacing: 4,
                      spacing: 4,
                      children: [
                        _buildBadge(context, 'Evento'),
                        _buildBadge(context, 'Esportivo'),
                      ],
                    ),
                  ],
                ),
              ),
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
        style: context.theme.typography.sm.copyWith(
          fontWeight: FontWeight.normal,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _getEventImage({
    required BuildContext context,
    required FThemeData theme,
    String? coverImgUrl = '',
  }) {
    return ContentMedia(
      source: NetworkMedia(url: coverImgUrl ?? ''),
      fit: BoxFit.cover,
      errorWidget: Container(
        color: theme.colors.muted,
        child: Icon(
          getEntityIcon(.event),
          color: theme.colors.mutedForeground,
          size: 32,
        ),
      ),
    );
  }
}
