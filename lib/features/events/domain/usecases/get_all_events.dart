import 'package:dartz/dartz.dart';
import 'package:ibiapabaapp/core/errors/failures/failures.dart';
import 'package:ibiapabaapp/core/usecases/usecase_without_params.dart';
import 'package:ibiapabaapp/shared/models/event.dart';
import 'package:ibiapabaapp/features/events/domain/repositories/events_repository.dart';

class GetAllEvents implements UsecaseWithoutParams {
  final EventsRepository repository;
  GetAllEvents(this.repository);

  @override
  Future<Either<AppFailure, List<Event>>> call() {
    return repository.getAllEvents();
  }
}
