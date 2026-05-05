import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ibiapabaapp/core/logger/handlers/controller_log_handler.dart';
import 'package:ibiapabaapp/core/logger/log_tags.dart';
import 'package:ibiapabaapp/core/logger/logger.dart';
import 'package:ibiapabaapp/core/session/app_session_notifier_provider.dart';
import 'package:ibiapabaapp/features/events/domain/entities/event.dart';
import 'package:ibiapabaapp/features/events/domain/tags/events_logtags.dart';
import 'package:ibiapabaapp/features/events/domain/usecases/get_event_by_id.dart';
import 'package:ibiapabaapp/features/events/presentation/providers/events_providers.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'events_controller.g.dart';

@riverpod
class Events extends _$Events with ControllerLogHandler {
  @override
  late final Logger logger = ref.read(loggerProvider);

  @override
  LogFeature get feature => LogFeature.events;

  @override
  Future<List<Event>> build() async {
    ref.listen(appSessionProvider, (previous, next) {
      final account = next.account;
      final previousAccount = previous?.account;
      if (account != null && previousAccount == null) {
        getAllEvents();
      } else if (account == null) {
        state = const AsyncData([]);
      }
    });

    final user = ref.watch(appSessionProvider.select((s) => s.account));
    if (user == null) return [];
    return _fetchRemote();
  }

  Future<List<Event>> _fetchRemote() async {
    final getAllEventsUsecase = ref.read(getAllEventsProvider);
    final result = await getAllEventsUsecase();

    if (!ref.mounted) throw Exception('Provider disposed');

    return result.fold(
      (failure) {
        logControllerError(action: EventAction.getAllEvents, failure: failure);
        throw Exception(failure.message);
      },
      (events) {
        logControllerSuccess(action: EventAction.getAllEvents);
        return events;
      },
    );
  }

  Future<void> getAllEvents() async {
    state = const AsyncLoading();
    final usecase = ref.read(getAllEventsProvider);
    final result = await usecase();

    if (!ref.mounted) return;

    result.fold(
      (failure) {
        logControllerError(action: EventAction.getAllEvents, failure: failure);
        state = AsyncError(failure.message, StackTrace.current);
      },
      (events) {
        logControllerSuccess(action: EventAction.getAllEvents);
        state = AsyncData(events);
      },
    );
  }

  Future<void> getEventById(String id) async {
    if (state is! AsyncData<List<Event>>) return;
    final currentEvents = (state as AsyncData<List<Event>>).value;

    state = const AsyncLoading();
    final usecase = ref.read(getEventByIdProvider);
    final result = await usecase(GetEventByIdParams(id: id));

    if (!ref.mounted) return;

    result.fold(
      (failure) {
        logControllerError(action: EventAction.getEventById, failure: failure);
        state = AsyncError(failure.message, StackTrace.current);
      },
      (event) {
        logControllerSuccess(action: EventAction.getEventById);
        if (event != null) {
          final updated = [...currentEvents];
          final index = updated.indexWhere((e) => e.id == event.id);
          if (index >= 0) {
            updated[index] = event;
          } else {
            updated.add(event);
          }
          state = AsyncData(updated);
        } else {
          state = AsyncData(currentEvents);
        }
      },
    );
  }

  Future<void> refresh() async {
    await getAllEvents();
  }
}
