import 'package:dartz/dartz.dart';
import 'package:ibiapabaapp/core/errors/failures/failures.dart';
import 'package:ibiapabaapp/core/logger/log_tags.dart';
import 'package:ibiapabaapp/core/logger/handlers/repository_log_handler.dart';
import 'package:ibiapabaapp/features/events/data/datasources/events_remote_datasource.dart';
import 'package:ibiapabaapp/features/events/domain/entities/event.dart';
import 'package:ibiapabaapp/features/events/domain/repositories/events_repository.dart';
import 'package:logger/logger.dart';

class EventsRepositoryImpl
    with RepositoryLogHandler
    implements EventsRepository {
  @override
  final Logger logger;
  final EventsRemoteDatasource remoteDatasource;

  EventsRepositoryImpl({required this.remoteDatasource, required this.logger});

  @override
  LogFeature get feature => LogFeature.companies;

  @override
  Future<Either<AppFailure, List<Event>>> getAllEvents() async {
    try {
      final result = await remoteDatasource.getAllEvents();
      return Right(result);
    } catch (e, stack) {
      return Left(
        handleRepositoryError(
          exception: e,
          stackTrace: stack,
          action: EventAction.getAllEvents,
        ),
      );
    }
  }

  @override
  Future<Either<AppFailure, Event?>> getEventById(String id) async {
    try {
      final result = await remoteDatasource.getEventById(id);
      return Right(result);
    } catch (e, stack) {
      return Left(
        handleRepositoryError(
          exception: e,
          stackTrace: stack,
          action: EventAction.getEventById,
        ),
      );
    }
  }
}
