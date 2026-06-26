import 'package:ibiapabaapp/core/entities/entity_type.dart';
import 'package:ibiapabaapp/core/logger/handlers/controller_log_handler.dart';
import 'package:ibiapabaapp/core/logger/log_tags.dart';
import 'package:ibiapabaapp/core/logger/logger.dart';
import 'package:ibiapabaapp/shared/providers/accounts_state_provider.dart';
import 'package:ibiapabaapp/features/cities/domain/entities/city_detail_data.dart';
import 'package:ibiapabaapp/features/cities/domain/tags/cities_logtags.dart';
import 'package:ibiapabaapp/features/cities/presentation/providers/cities_providers.dart';
import 'package:ibiapabaapp/features/medias/presentation/providers/medias_providers.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'city_detail_controller.g.dart';

@riverpod
class CityDetail extends _$CityDetail with ControllerLogHandler {
  @override
  late final Logger logger = ref.read(loggerProvider);

  @override
  LogFeature get feature => LogFeature.cities;

  @override
  Future<CityDetailData?> build(String id) async {
    final user = ref.watch(accountsStateProvider).activeAccount;
    if (user == null) return null;

    final repository = ref.read(citiesRepositoryProvider);
    final mediaRepository = ref.read(mediasRepositoryProvider);

    final cityFuture = repository.getCityById(id);
    final mediaFuture = mediaRepository.getEntityMedia(
      entityType: EntityType.city,
      entityId: id,
    );

    final city = await cityFuture;
    final media = await mediaFuture;

    if (!ref.mounted) throw Exception('Provider disposed');

    logControllerSuccess(action: CityAction.getCityById);

    if (city == null) return null;

    return CityDetailData(city: city, media: media);
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    ref.invalidateSelf();
    await future;
  }
}
