import 'package:dartz/dartz.dart';
import 'package:ibiapabaapp/core/errors/failures/failures.dart';
import 'package:ibiapabaapp/core/usecases/usecase.dart';
import 'package:ibiapabaapp/features/cities/domain/entities/city.dart';
import 'package:ibiapabaapp/features/cities/domain/repositories/cities_repository.dart';

class GetCityById implements Usecase<City?, GetCityByIdParams> {
  final CitiesRepository repository;
  GetCityById(this.repository);

  @override
  Future<Either<AppFailure, City?>> call(GetCityByIdParams params) {
    return repository.getCityById(params.id);
  }
}

class GetCityByIdParams {
  final String id;

  GetCityByIdParams({required this.id});
}
