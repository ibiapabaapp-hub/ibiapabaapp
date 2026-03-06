import 'package:dartz/dartz.dart';
import 'package:ibiapabaapp/core/errors/failures/failures.dart';
import 'package:ibiapabaapp/features/cities/domain/entities/city.dart';
import 'package:ibiapabaapp/features/cities/domain/repositories/cities_repository.dart';

class GetAllCities {
  final CitiesRepository repository;

  GetAllCities(this.repository);

  Future<Either<Failure, List<City>>> call() {
    return repository.getAllCities();
  }
}
