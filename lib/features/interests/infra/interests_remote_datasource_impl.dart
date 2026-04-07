import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ibiapabaapp/core/errors/failures/failures.dart';
import 'package:ibiapabaapp/core/network/dio_exception_to_app_exception_mapper.dart';
import 'package:ibiapabaapp/features/interests/data/datasouces/interests_remote_datasource.dart';
import 'package:ibiapabaapp/features/interests/domain/entities/user_interest_count.dart';
import 'package:ibiapabaapp/features/interests/domain/entities/user_interests.dart';
import 'package:ibiapabaapp/features/interests/infra/models/user_interests_count_model.dart';

class InterestsRemoteDatasourceImpl implements InterestsRemoteDatasource {
  final Dio dio;
  InterestsRemoteDatasourceImpl({required this.dio});

  @override
  Future<Either<AppFailure, UserInterestCount>> updateUserInterests({
    required String userId,
    required UserInterests interests,
  }) async {
    try {
      final response = await dio.put(
        '/users/$userId/interests',
        data: {
          'companies_ids': interests.companyIds,
          'events_ids': interests.eventIds,
        },
      );

      final data = response.data;
      if (data == null) {
        return Right(UserInterestsCountModel(count: 0));
      }

      return Right(UserInterestsCountModel.fromJson(data));
    } on DioException catch (e) {
      throw DioExceptionToAppExceptionMapper.map(e);
    }
  }
}
