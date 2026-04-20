import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ibiapabaapp/core/entities/entity_type.dart';
import 'package:ibiapabaapp/core/logger/handlers/controller_log_handler.dart';
import 'package:ibiapabaapp/core/logger/log_tags.dart';
import 'package:ibiapabaapp/core/logger/logger.dart';
import 'package:ibiapabaapp/core/session/app_session_notifier_provider.dart';
import 'package:ibiapabaapp/features/medias/domain/entity/media.dart';
import 'package:ibiapabaapp/features/medias/presentation/providers/medias_providers.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'medias_controller.g.dart';

@riverpod
class EntityMedias extends _$EntityMedias with ControllerLogHandler {
  @override
  late final Logger logger;

  @override
  LogFeature get feature => LogFeature.medias;

  @override
  Future<List<Media>> build(EntityType entityType, String entityId) async {
    logger = ref.read(loggerProvider);
    final user = ref.watch(appSessionProvider.select((s) => s.account));
    if (user == null) return [];

    return _fetchRemote(entityType, entityId);
  }

  Future<List<Media>> _fetchRemote(
    EntityType entityType,
    String entityId,
  ) async {
    final getEntityMedia = ref.read(getEntityMediaProvider);
    final result = await getEntityMedia(
      entityType: entityType,
      entityId: entityId,
    );

    if (!ref.mounted) throw Exception('Provider disposed');

    return result.fold(
      (failure) {
        logControllerError(
          action: MediaAction.getEntityMedia,
          failure: failure,
        );
        throw Exception(failure.message);
      },
      (media) {
        logControllerSuccess(action: MediaAction.getEntityMedia);
        return media;
      },
    );
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetchRemote(entityType, entityId));
  }
}
