import 'package:ibiapabaapp/shared/models/event.dart';

abstract class EventsRemoteDatasource {
  Future<List<Event>> getAllEvents();
  Future<Event> getEventById(String id);
}
