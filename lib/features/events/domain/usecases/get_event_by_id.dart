import 'package:dartz/dartz.dart';
import 'package:ibiapabaapp/core/errors/failures/failures.dart';
import 'package:ibiapabaapp/core/usecases/usecase.dart';
import 'package:ibiapabaapp/shared/models/event.dart';
import 'package:ibiapabaapp/features/events/domain/repositories/events_repository.dart';

class GetEventById implements Usecase<Event?, GetEventByIdParams> {
  final EventsRepository repository;
  GetEventById(this.repository);

  @override
  Future<Either<AppFailure, Event?>> call(GetEventByIdParams params) {
    return repository.getEventById(params.id);
  }
}

class GetEventByIdParams {
  final String id;

  const GetEventByIdParams({required this.id});
}
