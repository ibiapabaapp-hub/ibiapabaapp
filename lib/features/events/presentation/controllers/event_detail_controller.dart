import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ibiapabaapp/core/entities/entity_type.dart';
import 'package:ibiapabaapp/core/errors/failures/failures.dart';
import 'package:ibiapabaapp/core/logger/handlers/controller_log_handler.dart';
import 'package:ibiapabaapp/core/logger/log_tags.dart';
import 'package:ibiapabaapp/core/logger/logger.dart';
import 'package:ibiapabaapp/core/session/app_session_notifier_provider.dart';
import 'package:ibiapabaapp/features/events/domain/entities/event.dart';
import 'package:ibiapabaapp/features/events/domain/entities/event_detail_data.dart';
import 'package:ibiapabaapp/features/events/domain/usecases/get_event_by_id.dart';
import 'package:ibiapabaapp/features/events/presentation/providers/events_providers.dart';
import 'package:ibiapabaapp/features/medias/domain/entity/media.dart';
import 'package:ibiapabaapp/features/medias/presentation/providers/medias_providers.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'event_detail_controller.g.dart';

@riverpod
class EventDetail extends _$EventDetail with ControllerLogHandler {
  @override
  late final Logger logger;

  @override
  LogFeature get feature => LogFeature.events;

  @override
  Future<EventDetailData?> build(String id) async {
    logger = ref.read(loggerProvider);
    final user = ref.watch(appSessionProvider.select((s) => s.account));
    if (user == null) return null;

    final results = await Future.wait([
      ref.read(getEventByIdProvider).call(GetEventByIdParams(id: id)),
      ref
          .read(getEntityMediaProvider)
          .call(entityType: EntityType.event, entityId: id),
    ]);

    if (!ref.mounted) throw Exception('Provider disposed');

    final eventResult = results[0] as Either<AppFailure, Event?>;
    final mediaResult = results[1] as Either<AppFailure, List<Media>>;

    final event = eventResult.fold(
      (failure) {
        logControllerError(action: EventAction.getEventById, failure: failure);
        throw Exception(failure.message);
      },
      (eventData) {
        logControllerSuccess(action: EventAction.getAllEvents);
        return eventData;
      },
    );

    if (event == null) return null;

    final media = mediaResult.fold(
      (failure) {
        logControllerError(action: EventAction.getEventMedia, failure: failure);
        return <Media>[];
      },
      (media) {
        logControllerSuccess(action: EventAction.getEventMedia);
        return media;
      },
    );

    return EventDetailData(event: event, media: media);
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    ref.invalidateSelf();
    await future;
  }
}
