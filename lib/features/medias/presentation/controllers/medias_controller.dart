import 'package:ibiapabaapp/core/entities/entity_type.dart';
import 'package:ibiapabaapp/core/logger/handlers/controller_log_handler.dart';
import 'package:ibiapabaapp/core/logger/log_tags.dart';
import 'package:ibiapabaapp/core/logger/logger.dart';
import 'package:ibiapabaapp/shared/providers/accounts_state_provider.dart';
import 'package:ibiapabaapp/shared/models/media.dart';
import 'package:ibiapabaapp/features/medias/domain/tags/medias_logtags.dart';
import 'package:ibiapabaapp/features/medias/presentation/providers/medias_providers.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'medias_controller.g.dart';

@riverpod
class EntityMedias extends _$EntityMedias with ControllerLogHandler {
  @override
  late final Logger logger = ref.read(loggerProvider);

  @override
  LogFeature get feature => LogFeature.medias;

  @override
  Future<List<Media>> build(EntityType entityType, String entityId) async {
    final user = ref.watch(accountsStateProvider).activeAccount;
    if (user == null) return [];

    return _fetchRemote(entityType, entityId);
  }

  Future<List<Media>> _fetchRemote(
    EntityType entityType,
    String entityId,
  ) async {
    final repository = ref.read(mediasRepositoryProvider);
    try {
      final media = await repository.getEntityMedia(
        entityType: entityType,
        entityId: entityId,
      );
      if (!ref.mounted) throw Exception('Provider disposed');
      logControllerSuccess(action: MediaAction.getEntityMedia);
      return media;
    } catch (e) {
      if (!ref.mounted) throw Exception('Provider disposed');
      logControllerError(
        action: MediaAction.getEntityMedia,
        failure: e,
      );
      throw Exception(e.toString());
    }
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetchRemote(entityType, entityId));
  }
}
