import 'package:dio/dio.dart';
import 'package:ibiapabaapp/core/logger/handlers/repository_log_handler.dart';
import 'package:ibiapabaapp/core/logger/log_tags.dart';
import 'package:ibiapabaapp/shared/models/event.dart';
import 'package:ibiapabaapp/features/events/domain/repositories/events_repository.dart';
import 'package:ibiapabaapp/features/events/infra/models/event_model.dart';
import 'package:logger/logger.dart';

class EventsRepositoryImpl
    with RepositoryLogHandler
    implements EventsRepository {
  @override
  final Logger logger;
  final Dio dio;

  EventsRepositoryImpl({required this.dio, required this.logger});

  @override
  LogFeature get feature => LogFeature.events;

  @override
  Future<List<Event>> getAllEvents() async {
    final response = await dio.get('/events');
    return EventModel.fromJsonList(response.data);
  }

  @override
  Future<Event?> getEventById(String id) async {
    final response = await dio.get('/events/$id');
    return EventModel.fromJson(response.data);
  }
}
