import 'package:ibivibe/core/entities/entity_type.dart';
import 'package:ibivibe/core/logger/handlers/controller_log_handler.dart';
import 'package:ibivibe/core/logger/log_tags.dart';
import 'package:ibivibe/core/logger/logger.dart';
import 'package:ibivibe/shared/providers/accounts_viewmodel.dart';
import 'package:ibivibe/features/events/models/event_detail_data.dart';
import 'package:ibivibe/features/events/events_logtags.dart';
import 'package:ibivibe/features/events/events_providers.dart';
import 'package:ibivibe/features/medias/medias_providers.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'event_detail_viewmodel.g.dart';

@riverpod
class EventDetailViewModel extends _$EventDetailViewModel with ControllerLogHandler {
  @override
  late final Logger logger = ref.read(loggerProvider);

  @override
  LogFeature get feature => LogFeature.events;

  @override
  Future<EventDetailData?> build(String id) async {
    final user = ref.watch(accountsViewModelProvider).activeAccount;
    if (user == null) return null;

    final repository = ref.read(eventsRepositoryProvider);
    final mediaRepository = ref.read(mediasRepositoryProvider);

    final eventFuture = repository.getEventById(id);
    final mediaFuture = mediaRepository.getEntityMedia(
      entityType: EntityType.event,
      entityId: id,
    );

    final event = await eventFuture;
    final media = await mediaFuture;

    if (!ref.mounted) throw Exception('Provider disposed');

    logControllerSuccess(action: EventAction.getAllEvents);

    if (event == null) return null;

    return EventDetailData(event: event, media: media);
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    ref.invalidateSelf();
    await future;
  }
}
