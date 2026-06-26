import 'package:dartz/dartz.dart';
import 'package:ibiapabaapp/core/errors/failures/failures.dart';
import 'package:ibiapabaapp/core/usecases/usecase.dart';
import 'package:ibiapabaapp/shared/models/account_type.dart';
import 'package:ibiapabaapp/shared/models/gender.dart';
import 'package:ibiapabaapp/features/auth/domain/entities/complete_google_registration.dart';
import 'package:ibiapabaapp/features/auth/domain/repositories/auth_repository.dart';

class CompleteGoogleRegistration
    implements Usecase<CompleteGoogleRegistrationResponse, CompleteGoogleRegistrationParams> {
  final AuthRepository repository;

  CompleteGoogleRegistration(this.repository);

  @override
  Future<Either<AppFailure, CompleteGoogleRegistrationResponse>> call(
      CompleteGoogleRegistrationParams params) {
    return repository.completeGoogleRegistration(
      tempToken: params.tempToken,
      slug: params.slug,
      type: params.type,
      gender: params.gender,
    );
  }
}

class CompleteGoogleRegistrationParams {
  final String tempToken;
  final String slug;
  final AccountType type;
  final Gender? gender;

  const CompleteGoogleRegistrationParams({
    required this.tempToken,
    required this.slug,
    required this.type,
    this.gender,
  });
}
