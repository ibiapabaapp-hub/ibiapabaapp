import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:ibivibe/features/cities/models/city_detail_data.dart';
import 'package:ibivibe/features/cities/viewmodels/city_detail_viewmodel.dart';
import 'package:ibivibe/shared/ui/fragments/favorite_button.dart';
import 'package:ibivibe/shared/models/media.dart';
import 'package:ibivibe/shared/ui/fragments/carousel/content_carousel.dart';
import 'package:ibivibe/shared/ui/fragments/effects/default_shimmer_effect.dart';
import 'package:ibivibe/shared/ui/fragments/effects/expandable_text.dart';
import 'package:ibivibe/shared/ui/fragments/media/sources.dart';
import 'package:ibivibe/shared/ui/layout/section_header.dart';
import 'package:ibivibe/shared/ui/layout/wrappers/detail_page_wrapper.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CityDetailScreen extends ConsumerWidget {
  final String id;
  const CityDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailAsync = ref.watch(cityDetailViewModelProvider(id));

    return detailAsync.when(
      loading: () => const _CityDetailContent(isLoading: true, detail: null),
      error: (e, _) =>
          _ErrorView(onRetry: () => ref.invalidate(cityDetailViewModelProvider(id))),
      data: (detail) => _CityDetailContent(isLoading: false, detail: detail),
    );
  }
}

class _CityDetailContent extends StatelessWidget {
  final bool isLoading;
  final CityDetailData? detail;

  const _CityDetailContent({required this.isLoading, required this.detail});

  List<MediaSource> get _carouselItems {
    if (isLoading || detail == null || detail!.media.isEmpty) {
      return List.generate(3, (_) => NetworkMedia(url: ''));
    }

    return detail!.media.map((m) {
      return NetworkMedia(
        url: m.url,
        title: detail?.city.name,
        isVideo: m.mediaType == MediaType.video,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final city = detail?.city;

    return Skeletonizer(
      effect: customShimmerEffect(context),
      enabled: isLoading,
      child: DetailPageWrapper(
        carousel: ContentCarousel(
          items: _carouselItems,
          isLoading: isLoading,
          aspectRatio: 16 / 18,
        ),
        headerChildren: FHeader.nested(
          prefixes: [
            FButton.icon(
              style: FButtonStyle.secondary(),
              onPress: () => context.pop(),
              child: const Icon(Icons.arrow_back, size: 24),
            ),
          ],
          suffixes: [FavoriteButton(cityId: city?.id)],
        ),
        bodyChildren: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                city?.name ?? 'Carregando cidade',
                style: context.theme.typography.xl2.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                runSpacing: 6,
                spacing: 6,
                children: (city?.categories ?? ['Categoria', 'Subcategoria'])
                    .map(
                      (cat) => FBadge(
                        style: FBadgeStyle.secondary(),
                        child: Text(
                          cat,
                          style: context.theme.typography.sm.copyWith(
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 16),
              ExpandableText(
                text: isLoading
                    ? 'Este é um texto de exemplo para o skeleton ocupar espaço...'
                    : (city?.description ?? 'Sem descrição disponível.'),
              ),
              const FDivider(),
              SectionHeader(title: 'Acontecendo agora', onSeeAllTap: () {}),
              const SizedBox(height: 48),
            ],
          ),
        ],
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final VoidCallback onRetry;
  const _ErrorView({required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 16,
        children: [
          Icon(
            Icons.error_outline,
            color: context.theme.colors.mutedForeground,
            size: 64,
          ),
          Text('Erro ao carregar cidade', style: context.theme.typography.base),
          FButton(onPress: onRetry, child: const Text('Tentar novamente')),
        ],
      ),
    );
  }
}
