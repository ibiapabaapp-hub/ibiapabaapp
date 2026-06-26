import 'package:ibiapabaapp/shared/models/event.dart';

abstract class EventsRepository {
  Future<List<Event>> getAllEvents();
  Future<Event?> getEventById(String id);
}
