import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:ibivibe/shared/models/event.dart';
import 'package:ibivibe/features/events/presentation/controllers/events_controller.dart';
import 'package:ibivibe/shared/ui/fragments/events/event_card.dart';
import 'package:ibivibe/shared/ui/layout/section_header.dart';
import 'package:ibivibe/shared/models/business.dart';
import 'package:ibivibe/shared/ui/layout/vertical_items_list.dart';

final List<Event> _mockEvents = List.generate(
  3,
  (index) => Event(
    id: 'mock-$index',
    ownerAccountId: 'mock-$index-account',
    name: 'Carregando evento...',
    slug: 'mock',

    type: EventType.simple,
    reachLevel: ReachLevel.local,
    coverImgUrl: '',
    categories: ['Categoria'],

    startDate: .now(),
    endDate: .now(),

    createdAt: .now(),
    updatedAt: .now(),
  ),
);

class NowHappeningSection extends ConsumerStatefulWidget {
  const NowHappeningSection({super.key});

  @override
  ConsumerState<NowHappeningSection> createState() =>
      _NowHappeningSectionState();
}

class _NowHappeningSectionState extends ConsumerState<NowHappeningSection> {
  @override
  Widget build(BuildContext context) {
    final eventsAsync = ref.watch(eventsProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8,
        children: [
          SectionHeader(
            title: 'Acontecendo agora',
            onSeeAllTap: () => context.push('/app/events'),
          ),
          eventsAsync.when(
            skipLoadingOnRefresh: false,
            loading: () => VerticalItemsList(
              isLoading: true,
              items: _mockEvents,
              separator: const SizedBox(height: 16),
              itemBuilder: (_, event) => EventCard(event: event),
            ),

            error: (error, stack) => Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 16,
                  children: [
                    Icon(
                      Icons.error_outline,
                      color: context.theme.colors.mutedForeground,
                      size: 48,
                    ),
                    Text(
                      'Erro ao carregar eventos',
                      style: context.theme.typography.base,
                    ),
                    FButton(
                      onPress: () => ref.invalidate(eventsProvider),
                      child: const Text('Tentar novamente'),
                    ),
                  ],
                ),
              ),
            ),

            data: (events) => VerticalItemsList(
              isLoading: false,
              items: events,
              separator: const SizedBox(height: 16),
              itemBuilder: (_, event) => EventCard(event: event),
            ),
          ),
        ],
      ),
    );
  }
}
