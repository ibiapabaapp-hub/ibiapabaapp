import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ibiapabaapp/core/logger/handlers/controller_log_handler.dart';
import 'package:ibiapabaapp/core/logger/log_tags.dart';
import 'package:ibiapabaapp/core/logger/logger.dart';
import 'package:ibiapabaapp/core/session/app_session_notifier_provider.dart';
import 'package:ibiapabaapp/features/businesses/domain/entities/business.dart';
import 'package:ibiapabaapp/features/businesses/domain/tags/businesses_logtags.dart';
import 'package:ibiapabaapp/features/businesses/presentation/providers/businesses_providers.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'businesses_controller.g.dart';

@riverpod
class Businesses extends _$Businesses with ControllerLogHandler {
  @override
  late final Logger logger = ref.read(loggerProvider);

  @override
  LogFeature get feature => LogFeature.businesses;

  @override
  Future<List<Business>> build() async {
    ref.listen(appSessionProvider, (previous, next) {
      final account = next.account;
      final previousAccount = previous?.account;
      if (account != null && previousAccount == null) {
        getAllBusinesses();
      } else if (account == null) {
        state = const AsyncData([]);
      }
    });

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
      (businesses) {
        logControllerSuccess(action: BusinessAction.getAllBusinesses);
        return businesses;
      },
    );
  }

  Future<void> getAllBusinesses() async {
    state = const AsyncLoading();
    final usecase = ref.read(getAllBusinessesProvider);
    final result = await usecase();

    if (!ref.mounted) return;

    result.fold(
      (failure) {
        logControllerError(
          action: BusinessAction.getAllBusinesses,
          failure: failure,
        );
        state = AsyncError(failure.message, StackTrace.current);
      },
      (businesses) {
        logControllerSuccess(action: BusinessAction.getAllBusinesses);
        state = AsyncData(businesses);
      },
    );
  }

  Future<void> getBusinessById(String id) async {
    if (state is! AsyncData<List<Business>>) return;
    final currentBusinesses = (state as AsyncData<List<Business>>).value;

    state = const AsyncLoading();
    final usecase = ref.read(getBusinessByIdProvider);
    final result = await usecase(id);

    if (!ref.mounted) return;

    result.fold(
      (failure) {
        logControllerError(
          action: BusinessAction.getBusinessById,
          failure: failure,
        );
        state = AsyncError(failure.message, StackTrace.current);
      },
      (business) {
        logControllerSuccess(action: BusinessAction.getBusinessById);
        if (business != null) {
          final updated = [...currentBusinesses];
          final index = updated.indexWhere((b) => b.id == business.id);
          if (index >= 0) {
            updated[index] = business;
          } else {
            updated.add(business);
          }
          state = AsyncData(updated);
        } else {
          state = AsyncData(currentBusinesses);
        }
      },
    );
  }

  Future<void> refresh() async {
    await getAllBusinesses();
  }
}
