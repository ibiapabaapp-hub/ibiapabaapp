import 'package:ibivibe/core/entities/entity_type.dart';
import 'package:ibivibe/core/logger/handlers/controller_log_handler.dart';
import 'package:ibivibe/core/logger/log_tags.dart';
import 'package:ibivibe/core/logger/logger.dart';
import 'package:ibivibe/shared/providers/accounts_viewmodel.dart';

import 'package:ibivibe/features/businesses/models/business_detail_data.dart';
import 'package:ibivibe/features/businesses/businesses_logtags.dart';
import 'package:ibivibe/features/businesses/providers/businesses_providers.dart';
import 'package:ibivibe/features/medias/providers/medias_providers.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'business_detail_viewmodel.g.dart';

@riverpod
class BusinessDetailViewModel extends _$BusinessDetailViewModel with ControllerLogHandler {
  @override
  late final Logger logger = ref.read(loggerProvider);

  @override
  LogFeature get feature => LogFeature.businesses;

  @override
  Future<BusinessDetailData?> build(String id) async {
    final user = ref.watch(accountsViewModelProvider).activeAccount;
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
