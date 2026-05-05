import 'package:ibiapabaapp/core/errors/failures/failures.dart';
import 'package:ibiapabaapp/core/logger/handlers/controller_log_handler.dart';
import 'package:ibiapabaapp/core/logger/log_tags.dart';
import 'package:ibiapabaapp/core/logger/logger.dart';
import 'package:ibiapabaapp/core/session/app_session_notifier_provider.dart';
import 'package:ibiapabaapp/features/cities/domain/entities/city.dart';
import 'package:ibiapabaapp/features/cities/domain/usecases/get_all_cities.dart';
import 'package:ibiapabaapp/features/cities/presentation/providers/cities_providers.dart';
import 'package:ibiapabaapp/features/onboarding/domain/tags/onboarding_logtags.dart';
import 'package:ibiapabaapp/features/onboarding/presentation/states/business_data_states.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'business_data_controller.g.dart';

@Riverpod(keepAlive: true)
class BusinessDataController extends _$BusinessDataController
    with ControllerLogHandler {
  @override
  late final Logger logger = ref.read(loggerProvider);

  @override
  LogFeature get feature => LogFeature.onboarding;

  @override
  Future<BusinessDataState> build() async {
    ref.keepAlive();

    List<City> citiesList = [];
    final result = await ref
        .read(getAllCitiesProvider)
        .call(const GetAllCitiesParams());

    result.fold(
      (failure) {
        logControllerError(
          action: OnboardingAction.getCities,
          failure: failure,
        );
        return;
      },
      (cities) {
        logControllerSuccess(action: OnboardingAction.getCities);
        citiesList = cities;
      },
    );

    return BusinessDataState(
      status: BusinessDataStatus.initial,
      cities: citiesList,
    );
  }

  Future<bool> submit() async {
    final account = ref.read(appSessionProvider).account;

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
