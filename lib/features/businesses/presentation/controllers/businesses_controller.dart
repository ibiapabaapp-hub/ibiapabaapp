import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ibiapabaapp/core/logger/handlers/controller_log_handler.dart';
import 'package:ibiapabaapp/core/logger/log_tags.dart';
import 'package:ibiapabaapp/core/logger/logger.dart';
import 'package:ibiapabaapp/core/session/app_session_notifier_provider.dart';
import 'package:ibiapabaapp/features/businesses/domain/entities/business.dart';
import 'package:ibiapabaapp/features/businesses/presentation/providers/businesses_providers.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'businesses_controller.g.dart';

@riverpod
class Businesses extends _$Businesses with ControllerLogHandler {
  @override
  late final Logger logger;

  @override
  LogFeature get feature => LogFeature.businesses;

  @override
  Future<List<Business>> build() async {
    logger = ref.read(loggerProvider);
    final user = ref.watch(appSessionProvider.select((s) => s.account));
    if (user == null) return [];
    return _fetchRemote();
  }

  Future<List<Business>> _fetchRemote() async {
    final getAllBusinessesUsecase = ref.read(getAllBusinessesProvider);
    final result = await getAllBusinessesUsecase();

    if (!ref.mounted) throw Exception('Provider disposed');

    return result.fold(
      (failure) {
        logControllerError(
          action: BusinessAction.getAllBusinesses,
          failure: failure,
        );
        throw Exception(failure.message);
      },
      (businesses) async {
        logControllerSuccess(action: BusinessAction.getAllBusinesses);
        return businesses;
      },
    );
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetchRemote());
  }
}
