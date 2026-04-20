import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ibiapabaapp/core/logger/handlers/controller_log_handler.dart';
import 'package:ibiapabaapp/core/logger/log_tags.dart';
import 'package:ibiapabaapp/core/logger/logger.dart';
import 'package:ibiapabaapp/core/session/app_session_notifier_provider.dart';
import 'package:ibiapabaapp/features/events/domain/entities/event.dart';
import 'package:ibiapabaapp/features/events/presentation/providers/events_providers.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'events_controller.g.dart';

@riverpod
class Events extends _$Events with ControllerLogHandler {
  @override
  late final Logger logger;

  @override
  LogFeature get feature => LogFeature.events;

  @override
  Future<List<Event>> build() async {
    logger = ref.read(loggerProvider);
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
      (events) async {
        logControllerSuccess(action: EventAction.getAllEvents);
        return events;
      },
    );
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetchRemote());
  }
}
