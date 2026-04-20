import 'package:ibiapabaapp/core/logger/logger.dart';
import 'package:ibiapabaapp/core/network/dio_provider.dart';
import 'package:ibiapabaapp/features/events/data/datasources/events_remote_datasource.dart';
import 'package:ibiapabaapp/features/events/data/repositories/events_repository_impl.dart';
import 'package:ibiapabaapp/features/events/domain/repositories/events_repository.dart';
import 'package:ibiapabaapp/features/events/domain/usecases/get_all_events.dart';
import 'package:ibiapabaapp/features/events/domain/usecases/get_event_by_id.dart';
import 'package:ibiapabaapp/features/events/infra/events_remote_datasource_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'events_providers.g.dart';

// DATA
@riverpod
EventsRemoteDatasource eventsRemoteDatasource(Ref ref) {
  final dio = ref.watch(dioProvider);
  return EventsRemoteDatasourceImpl(dio);
}

@riverpod
EventsRepository eventsRepository(Ref ref) {
  final logger = ref.watch(loggerProvider);
  final remoteDatasource = ref.watch(eventsRemoteDatasourceProvider);
  return EventsRepositoryImpl(
    remoteDatasource: remoteDatasource,
    logger: logger,
  );
}

// USECASES
@riverpod
GetAllEvents getAllEvents(Ref ref) {
  final repository = ref.watch(eventsRepositoryProvider);
  return GetAllEvents(repository);
}

@riverpod
GetEventById getEventById(Ref ref) {
  final repository = ref.watch(eventsRepositoryProvider);
  return GetEventById(repository);
}
