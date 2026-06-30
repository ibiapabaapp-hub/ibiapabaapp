import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:ibivibe/shared/models/event.dart';
import 'package:ibivibe/features/events/viewmodels/events_viewmodel.dart';
import 'package:ibivibe/shared/ui/fragments/events/event_card.dart';
import 'package:ibivibe/shared/ui/fragments/toast/show_app_toast.dart';
import 'package:ibivibe/shared/ui/layout/section_header.dart';
import 'package:ibivibe/shared/ui/layout/vertical_items_list.dart';

final List<Event> _mockEvents = List.generate(
  5,
  (index) => Event(
    id: 'mock-$index',
    ownerAccountId: 'mock-$index-account',
    slug: '',
    name: 'Carregando evento...',

    description: '',
    type: .featured,
    reachLevel: .regional,
    coverImgUrl: '',
    tags: ['Categoria', 'Subcategoria'],

    startDate: .now(),
    endDate: .now(),

    createdAt: .now(),
    updatedAt: .now(),
  ),
);

class EventsOverviewScreen extends ConsumerStatefulWidget {
  const EventsOverviewScreen({super.key});

  @override
  ConsumerState<EventsOverviewScreen> createState() =>
      _EventsOverviewScreenState();
}

class _EventsOverviewScreenState extends ConsumerState<EventsOverviewScreen> {
  @override
  Widget build(BuildContext context) {
    final eventsAsync = ref.watch(eventsViewModelProvider);

    return Column(
      children: [
        FHeader.nested(
          title: Text('Eventos', style: context.theme.typography.base),
          prefixes: [
            FButton.icon(
              style: FButtonStyle.ghost(),
              onPress: () => context.pop(),
              child: const Icon(Icons.arrow_back_rounded, size: 24),
            ),
          ],
          suffixes: [
            FButton.icon(
              style: FButtonStyle.ghost(),
              onPress: () {
                showAppToast(
                  context: context,
                  title: 'TODO: Implementar redirect para busca',
                );
              },
              child: const Icon(Icons.search, size: 24),
            ),
          ],
        ),
        Expanded(
          child: eventsAsync.when(
            skipLoadingOnRefresh: false,
            loading: () => _Content(events: _mockEvents, isLoading: true),
            error: (error, stack) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 16,
                children: [
                  Icon(
                    Icons.error_outline,
                    color: context.theme.colors.mutedForeground,
                    size: 64,
                  ),
                  Text(
                    'Erro ao carregar eventos',
                    style: context.theme.typography.base,
                  ),
                  FButton(
                    onPress: () => ref.invalidate(eventsViewModelProvider),
                    child: const Text('Tentar novamente'),
                  ),
                ],
              ),
            ),
            data: (events) => _Content(events: events, isLoading: false),
          ),
        ),
      ],
    );
  }
}

class _Content extends StatelessWidget {
  final List<Event> events;
  final bool isLoading;

  const _Content({required this.events, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      children: [
        _Section(
          events: events,
          isLoading: isLoading,
          header: const SectionHeader(
            title: 'Próximos Eventos',
            onSeeAllTap: null,
          ),
        ),
      ],
    );
  }
}

class _Section extends StatelessWidget {
  final bool isLoading;
  final SectionHeader header;
  final List<Event> events;

  const _Section({
    required this.events,
    required this.header,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8,
        children: [
          header,
          VerticalItemsList(
            separator: const SizedBox(height: 16),
            isLoading: isLoading,
            items: events,
            itemBuilder: (_, event) => EventCard(event: event),
          ),
        ],
      ),
    );
  }
}
