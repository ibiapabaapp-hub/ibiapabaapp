import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ibiapabaapp/features/events/domain/entities/event.dart';
import 'package:ibiapabaapp/shared/ui/fragments/events/event_card.dart';
import 'package:ibiapabaapp/shared/ui/layout/section_header.dart';

class NowHappeningSection extends StatelessWidget {
  const NowHappeningSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Event> eventList = [
      Event(
        id: '1',
        slug: 'slug',
        name: 'name',
        type: EventType.simple,
        reachLevel: EventReachLevel.local,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      Event(
        id: '1',
        slug: 'slug',
        name: 'name',
        type: EventType.simple,
        reachLevel: EventReachLevel.local,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    ];

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: 'Acontecendo agora',
          onSeeAllTap: () => context.push('/app/events'),
        ),
        const SizedBox(height: 16),

        SizedBox(
          height: 150,
          child: ListView.separated(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: eventList.length,
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              return SizedBox(
                width: 450,
                child: EventCard(event: eventList.elementAt(index)),
              );
            },
          ),
        ),
      ],
    );
  }
}
