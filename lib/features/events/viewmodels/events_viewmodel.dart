import 'package:ibivibe/core/logger/handlers/controller_log_handler.dart';
import 'package:ibivibe/core/logger/log_tags.dart';
import 'package:ibivibe/core/logger/logger.dart';
import 'package:ibivibe/shared/providers/accounts_viewmodel.dart';
import 'package:ibivibe/shared/models/event.dart';
import 'package:ibivibe/features/events/events_logtags.dart';
import 'package:ibivibe/features/events/providers/events_providers.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'events_viewmodel.g.dart';

@riverpod
class EventsViewModel extends _$EventsViewModel with ControllerLogHandler {
  @override
  late final Logger logger = ref.read(loggerProvider);

  @override
  LogFeature get feature => LogFeature.events;

  @override
  Future<List<Event>> build() async {
    ref.listen(accountsViewModelProvider, (previous, next) {
      final account = next.activeAccount;
      final previousAccount = previous?.activeAccount;
      if (account != null && previousAccount == null) {
        getAllEvents();
      } else if (account == null) {
        state = const AsyncData([]);
      }
    });

    final user = ref.watch(accountsViewModelProvider).activeAccount;
    if (user == null) return [];
    return _fetchRemote();
  }

  Future<List<Event>> _fetchRemote() async {
    final repository = ref.read(eventsRepositoryProvider);
    try {
      final events = await repository.getAllEvents();
      if (!ref.mounted) throw Exception('Provider disposed');
      logControllerSuccess(action: EventAction.getAllEvents);
      return events;
    } catch (e) {
      logControllerError(action: EventAction.getAllEvents, failure: e);
      throw Exception(e.toString());
    }
  }

  Future<void> getAllEvents() async {
    state = const AsyncLoading();
    final repository = ref.read(eventsRepositoryProvider);
    try {
      final events = await repository.getAllEvents();
      if (!ref.mounted) return;
      logControllerSuccess(action: EventAction.getAllEvents);
      state = AsyncData(events);
    } catch (e) {
      logControllerError(action: EventAction.getAllEvents, failure: e);
      state = AsyncError(e.toString(), StackTrace.current);
    }
  }

  Future<void> getEventById(String id) async {
    if (state is! AsyncData<List<Event>>) return;
    final currentEvents = (state as AsyncData<List<Event>>).value;

    state = const AsyncLoading();
    final repository = ref.read(eventsRepositoryProvider);
    try {
      final event = await repository.getEventById(id);
      if (!ref.mounted) return;
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
    } catch (e) {
      logControllerError(action: EventAction.getEventById, failure: e);
      state = AsyncError(e.toString(), StackTrace.current);
    }
  }

  Future<void> refresh() async {
    await getAllEvents();
  }
}
