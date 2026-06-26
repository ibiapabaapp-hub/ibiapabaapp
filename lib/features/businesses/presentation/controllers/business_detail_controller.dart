import 'package:dartz/dartz.dart';
import 'package:ibiapabaapp/core/entities/entity_type.dart';
import 'package:ibiapabaapp/core/errors/failures/failures.dart';
import 'package:ibiapabaapp/core/logger/handlers/controller_log_handler.dart';
import 'package:ibiapabaapp/core/logger/log_tags.dart';
import 'package:ibiapabaapp/core/logger/logger.dart';
import 'package:ibiapabaapp/features/accounts/presentation/providers/accounts_state_provider.dart';
import 'package:ibiapabaapp/shared/models/business.dart';
import 'package:ibiapabaapp/features/businesses/domain/entities/business_detail_data.dart';
import 'package:ibiapabaapp/features/businesses/domain/tags/businesses_logtags.dart';
import 'package:ibiapabaapp/features/businesses/presentation/providers/businesses_providers.dart';
import 'package:ibiapabaapp/shared/models/media.dart';
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

    final results = await Future.wait([
      ref.read(getBusinessByIdProvider).call(id),
      ref
          .read(getEntityMediaProvider)
          .call(entityType: EntityType.business, entityId: id),
    ]);

    if (!ref.mounted) throw Exception('Provider disposed');

    final businessResult = results[0] as Either<AppFailure, Business?>;
    final mediaResult = results[1] as Either<AppFailure, List<Media>>;

    final business = businessResult.fold(
      (failure) {
        logControllerError(
          action: BusinessAction.getBusinessById,
          failure: failure,
        );
        throw Exception(failure.message);
      },
      (businessData) {
        logControllerSuccess(action: BusinessAction.getBusinessById);
        return businessData;
      },
    );

    if (business == null) return null;

    final media = mediaResult.fold(
      (failure) {
        logControllerError(
          action: BusinessAction.getBusinessMedia,
          failure: failure,
        );
        return <Media>[];
      },
      (media) {
        logControllerSuccess(action: BusinessAction.getBusinessMedia);
        return media;
      },
    );

    return BusinessDetailData(business: business, media: media);
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    ref.invalidateSelf();
    await future;
  }
}
