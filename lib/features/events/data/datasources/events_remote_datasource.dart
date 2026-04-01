import 'package:ibiapabaapp/features/events/domain/entities/event.dart';

abstract class EventsRemoteDatasource {
  Future<List<Event>> getAllEvents();
  Future<Event> getEventById(String id);
}
