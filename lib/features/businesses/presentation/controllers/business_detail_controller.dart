import 'package:ibiapabaapp/core/entities/entity_type.dart';
import 'package:ibiapabaapp/core/logger/handlers/controller_log_handler.dart';
import 'package:ibiapabaapp/core/logger/log_tags.dart';
import 'package:ibiapabaapp/core/logger/logger.dart';
import 'package:ibiapabaapp/shared/providers/accounts_state_provider.dart';

import 'package:ibiapabaapp/features/businesses/domain/entities/business_detail_data.dart';
import 'package:ibiapabaapp/features/businesses/domain/tags/businesses_logtags.dart';
import 'package:ibiapabaapp/features/businesses/presentation/providers/businesses_providers.dart';
import 'package:ibiapabaapp/features/medias/presentation/providers/medias_providers.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'business_detail_controller.g.dart';

@riverpod
class BusinessDetail extends _$BusinessDetail with ControllerLogHandler {
  @override
  late final Logger logger = ref.read(loggerProvider);

  @override
  LogFeature get feature => LogFeature.businesses;

  @override
  Future<BusinessDetailData?> build(String id) async {
    final user = ref.watch(accountsStateProvider).activeAccount;
    if (user == null) return null;

    final repository = ref.read(businessesRepositoryProvider);
    final mediaRepository = ref.read(mediasRepositoryProvider);

    final businessFuture = repository.getBusinessById(id);
    final mediaFuture = mediaRepository.getEntityMedia(
      entityType: EntityType.business,
      entityId: id,
    );

    final business = await businessFuture;
    final media = await mediaFuture;

    if (!ref.mounted) throw Exception('Provider disposed');

    logControllerSuccess(action: BusinessAction.getBusinessById);

    if (business == null) return null;

    return BusinessDetailData(business: business, media: media);
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    ref.invalidateSelf();
    await future;
  }
}
