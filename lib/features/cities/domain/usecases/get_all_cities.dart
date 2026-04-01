import 'package:dartz/dartz.dart';
import 'package:ibiapabaapp/core/errors/failures/failures.dart';
import 'package:ibiapabaapp/core/usecases/usecase.dart';
import 'package:ibiapabaapp/features/cities/domain/entities/city.dart';
import 'package:ibiapabaapp/features/cities/domain/repositories/cities_repository.dart';

class GetAllCities implements Usecase<List<City>, GetAllCitiesParams> {
  final CitiesRepository repository;
  GetAllCities(this.repository);

  @override
  Future<Either<AppFailure, List<City>>> call(GetAllCitiesParams params) {
    return repository.getAllCities(forceRefresh: params.forceRefresh);
  }
}

class GetAllCitiesParams {
  final bool forceRefresh;
  const GetAllCitiesParams({this.forceRefresh = false});
}
