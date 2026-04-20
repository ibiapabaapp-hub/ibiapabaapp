import 'package:dartz/dartz.dart';
import 'package:ibiapabaapp/core/errors/failures/failures.dart';
import 'package:ibiapabaapp/features/events/domain/entities/event.dart';

abstract class EventsRepository {
  Future<Either<AppFailure, List<Event>>> getAllEvents();
  Future<Either<AppFailure, Event?>> getEventById(String id);
}
