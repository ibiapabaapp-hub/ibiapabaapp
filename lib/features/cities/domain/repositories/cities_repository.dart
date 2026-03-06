import 'package:dartz/dartz.dart';
import 'package:ibiapabaapp/core/errors/failures/failures.dart';
import 'package:ibiapabaapp/features/cities/domain/entities/city.dart';

abstract class CitiesRepository {
  Future<Either<Failure, List<City>>> getAllCities();
}
