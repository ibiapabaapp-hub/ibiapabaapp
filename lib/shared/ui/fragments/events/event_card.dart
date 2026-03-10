import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:ibiapabaapp/features/events/domain/entities/event.dart';

class EventCard extends StatelessWidget {
  final Event event;
  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return FCard(
      style: (style) => style.copyWith(
        contentStyle: (style) =>
            style.copyWith(padding: const EdgeInsets.all(12)),
        decoration: style.decoration.copyWith(
          border: Border.all(width: 0),
          borderRadius: BorderRadius.circular(16),
          color: context.theme.colors.secondary,
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          bool isSmallScreen = constraints.maxWidth < 400;

          List<Widget> children = [
            GestureDetector(
              onTap: () {
                context.push('/app/events/${event.id}');
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                child: Image.network(
                  fit: BoxFit.cover,
                  width: isSmallScreen ? double.infinity : 120,
                  height: 120,
                  // TODO: event.imageUrl
                  'https://instagram.fjdo10-1.fna.fbcdn.net/v/t51.82787-15/619274405_17932095936169278_9113178893503771846_n.jpg?stp=dst-jpg_e35_tt6&_nc_cat=102&ig_cache_key=MzgxNTcwMjMyMDU4NDI1NDIwOQ%3D%3D.3-ccb7-5&ccb=7-5&_nc_sid=58cdad&efg=eyJ2ZW5jb2RlX3RhZyI6InhwaWRzLjEzNDd4MTY3OS5zZHIuQzMifQ%3D%3D&_nc_ohc=Aqmq0VcUj00Q7kNvwGW_3yI&_nc_oc=Adk59Yq6XcxK43LG7PhxZN-rxet_RjjtlAj_hAZ_Vpq5-ej2dnLCz309WXYzvWHctXpE0TqO4EpQbZbMa8yFQ5DG&_nc_ad=z-m&_nc_cid=0&_nc_zt=23&_nc_ht=instagram.fjdo10-1.fna&_nc_gid=oyYpeGPvc3efwquyHNHfWA&oh=00_AfvKfCH_xjwZOZySns1Axal11wiOFTd7hcgu4KB4bTGoPQ&oe=69A4E906',
                ),
              ),
            ),
            isSmallScreen
                ? _buildContent(context)
                : Expanded(child: _buildContent(context)),
          ];

          return isSmallScreen
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 16,
                  children: children,
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 16,
                  children: children,
                );
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Text(
          event.name,
          style: context.theme.typography.base.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          // TODO: event.date
          '28 e 29 de março',
          style: context.theme.typography.sm.copyWith(
            color: context.theme.colors.mutedForeground,
          ),
        ),
        Wrap(
          runSpacing: 6,
          spacing: 6,
          children: [
            // TODO: event.categories
            _buildBadge(context, 'Evento'),
            _buildBadge(context, 'Aberto ao público'),
            _buildBadge(context, 'Esportivo'),
          ],
        ),
      ],
    );
  }

  Widget _buildBadge(BuildContext context, String text) {
    return FBadge(
      style: FBadgeStyle.outline(),
      child: Text(
        text,
        style: context.theme.typography.sm.copyWith(
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
