import 'package:ibiapabaapp/core/entities/entity_type.dart';
import 'package:ibiapabaapp/core/logger/handlers/controller_log_handler.dart';
import 'package:ibiapabaapp/core/logger/log_tags.dart';
import 'package:ibiapabaapp/core/logger/logger.dart';
import 'package:ibiapabaapp/shared/providers/accounts_state_provider.dart';
import 'package:ibiapabaapp/features/events/domain/entities/event_detail_data.dart';
import 'package:ibiapabaapp/features/events/domain/tags/events_logtags.dart';
import 'package:ibiapabaapp/features/events/presentation/providers/events_providers.dart';
import 'package:ibiapabaapp/features/medias/presentation/providers/medias_providers.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'event_detail_controller.g.dart';

@riverpod
class EventDetail extends _$EventDetail with ControllerLogHandler {
  @override
  late final Logger logger = ref.read(loggerProvider);

  @override
  LogFeature get feature => LogFeature.events;

  @override
  Future<EventDetailData?> build(String id) async {
    final user = ref.watch(accountsStateProvider).activeAccount;
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
