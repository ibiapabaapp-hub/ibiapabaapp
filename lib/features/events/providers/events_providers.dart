import 'package:ibivibe/core/logger/logger.dart';
import 'package:ibivibe/core/network/dio_provider.dart';
import 'package:ibivibe/features/events/events_repository_impl.dart';
import 'package:ibivibe/features/events/events_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'events_providers.g.dart';

@riverpod
EventsRepository eventsRepository(Ref ref) {
  final logger = ref.watch(loggerProvider);
  final dio = ref.watch(dioProvider);
  return EventsRepositoryImpl(
    dio: dio,
    logger: logger,
  );
}
