import 'package:ibiapabaapp/core/logger/handlers/controller_log_handler.dart';
import 'package:ibiapabaapp/core/logger/log_tags.dart';
import 'package:ibiapabaapp/core/logger/logger.dart';
import 'package:ibiapabaapp/shared/providers/accounts_state_provider.dart';
import 'package:ibiapabaapp/shared/models/business.dart';
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
    ref.listen(accountsStateProvider, (previous, next) {
      final account = next.activeAccount;
      final previousAccount = previous?.activeAccount;
      if (account != null && previousAccount == null) {
        getAllBusinesses();
      } else if (account == null) {
        state = const AsyncData([]);
      }
    });

    final user = ref.watch(accountsStateProvider).activeAccount;
    if (user == null) return [];
    return _fetchRemote();
  }

  Future<List<Business>> _fetchRemote() async {
    final repository = ref.read(businessesRepositoryProvider);
    try {
      final businesses = await repository.getAllBusinesses();
      if (!ref.mounted) throw Exception('Provider disposed');
      logControllerSuccess(action: BusinessAction.getAllBusinesses);
      return businesses;
    } catch (e) {
      logControllerError(action: BusinessAction.getAllBusinesses, failure: e);
      throw Exception(e.toString());
    }
  }

  Future<void> getAllBusinesses() async {
    state = const AsyncLoading();
    final repository = ref.read(businessesRepositoryProvider);
    try {
      final businesses = await repository.getAllBusinesses();
      if (!ref.mounted) return;
      logControllerSuccess(action: BusinessAction.getAllBusinesses);
      state = AsyncData(businesses);
    } catch (e) {
      logControllerError(action: BusinessAction.getAllBusinesses, failure: e);
      state = AsyncError(e.toString(), StackTrace.current);
    }
  }

  Future<void> getBusinessById(String id) async {
    if (state is! AsyncData<List<Business>>) return;
    final currentBusinesses = (state as AsyncData<List<Business>>).value;

    state = const AsyncLoading();
    final repository = ref.read(businessesRepositoryProvider);
    try {
      final business = await repository.getBusinessById(id);
      if (!ref.mounted) return;
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
    } catch (e) {
      logControllerError(action: BusinessAction.getBusinessById, failure: e);
      state = AsyncError(e.toString(), StackTrace.current);
    }
  }

  Future<void> refresh() async {
    await getAllBusinesses();
  }
}
