import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ibiapabaapp/core/entities/entity_type.dart';
import 'package:ibiapabaapp/core/errors/failures/failures.dart';
import 'package:ibiapabaapp/core/logger/handlers/controller_log_handler.dart';
import 'package:ibiapabaapp/core/logger/log_tags.dart';
import 'package:ibiapabaapp/core/logger/logger.dart';
import 'package:ibiapabaapp/core/session/app_session_notifier_provider.dart';
import 'package:ibiapabaapp/features/cities/domain/entities/city.dart';
import 'package:ibiapabaapp/features/cities/domain/entities/city_detail_data.dart';
import 'package:ibiapabaapp/features/cities/domain/usecases/get_city_by_id.dart';
import 'package:ibiapabaapp/features/cities/presentation/providers/cities_providers.dart';
import 'package:ibiapabaapp/features/medias/domain/entity/media.dart';
import 'package:ibiapabaapp/features/medias/presentation/providers/medias_providers.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'city_detail_controller.g.dart';

@riverpod
class CityDetail extends _$CityDetail with ControllerLogHandler {
  @override
  late final Logger logger;

  @override
  LogFeature get feature => LogFeature.cities;

  @override
  Future<CityDetailData?> build(String id) async {
    logger = ref.read(loggerProvider);
    final user = ref.watch(appSessionProvider.select((s) => s.account));
    if (user == null) return null;

    final results = await Future.wait([
      ref.read(getCityByIdProvider).call(GetCityByIdParams(id: id)),
      ref
          .read(getEntityMediaProvider)
          .call(entityType: EntityType.city, entityId: id),
    ]);

    if (!ref.mounted) throw Exception('Provider disposed');

    final cityResult = results[0] as Either<AppFailure, City?>;
    final mediaResult = results[1] as Either<AppFailure, List<Media>>;

    final city = cityResult.fold(
      (failure) {
        logControllerError(action: CityAction.getCityById, failure: failure);
        throw Exception(failure.message);
      },
      (city) {
        logControllerSuccess(action: CityAction.getCityById);
        return city;
      },
    );

    if (city == null) return null;

    final media = mediaResult.fold(
      (failure) {
        logControllerError(action: CityAction.getCityMedia, failure: failure);
        return <Media>[];
      },
      (media) {
        logControllerSuccess(action: CityAction.getCityMedia);
        return media;
      },
    );

    return CityDetailData(city: city, media: media);
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    ref.invalidateSelf();
    await future;
  }
}
