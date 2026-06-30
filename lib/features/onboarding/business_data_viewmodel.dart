import 'package:ibivibe/core/errors/failures/failures.dart';
import 'package:ibivibe/core/logger/handlers/controller_log_handler.dart';
import 'package:ibivibe/core/logger/log_tags.dart';
import 'package:ibivibe/core/logger/logger.dart';
import 'package:ibivibe/shared/providers/accounts_viewmodel.dart';
import 'package:ibivibe/shared/models/city.dart';
import 'package:ibivibe/features/cities/cities_providers.dart';
import 'package:ibivibe/features/onboarding/onboarding_logtags.dart';
import 'package:ibivibe/features/onboarding/business_data_states.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'business_data_viewmodel.g.dart';

@Riverpod(keepAlive: true)
class BusinessDataViewModel extends _$BusinessDataViewModel
    with ControllerLogHandler {
  @override
  late final Logger logger = ref.read(loggerProvider);

  @override
  LogFeature get feature => LogFeature.onboarding;

  @override
  Future<BusinessDataState> build() async {
    ref.keepAlive();

    List<City> citiesList = [];
    try {
      final repository = ref.read(citiesRepositoryProvider);
      citiesList = await repository.getAllCities();
      logControllerSuccess(action: OnboardingAction.getCities);
    } catch (e) {
      logControllerError(
        action: OnboardingAction.getCities,
        failure: e,
      );
    }

    return BusinessDataState(
      status: BusinessDataStatus.initial,
      cities: citiesList,
    );
  }

  Future<bool> submit() async {
    final account = ref.read(accountsViewModelProvider).activeAccount;

    if (account == null) {
      logControllerError(
        action: OnboardingAction.submitInterests,
        failure: const InternalFailure(
          'Falha no envio: Usuário não encontrado na sessão',
        ),
      );
      return false;
    }

    return true;
  }
}
