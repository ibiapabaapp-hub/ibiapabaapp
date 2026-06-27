import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:ibivibe/features/events/domain/entities/event_detail_data.dart';
import 'package:ibivibe/features/events/presentation/controllers/event_detail_controller.dart';
import 'package:ibivibe/shared/ui/fragments/favorite_button.dart';
import 'package:ibivibe/shared/ui/fragments/carousel/content_carousel.dart';
import 'package:ibivibe/shared/ui/fragments/effects/default_shimmer_effect.dart';
import 'package:ibivibe/shared/ui/fragments/effects/expandable_text.dart';
import 'package:ibivibe/shared/ui/fragments/media/sources.dart';
import 'package:ibivibe/shared/ui/layout/wrappers/detail_page_wrapper.dart';
import 'package:skeletonizer/skeletonizer.dart';

class EventDetailScreen extends ConsumerWidget {
  final String id;
  const EventDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailAsync = ref.watch(eventDetailProvider(id));

    return detailAsync.when(
      loading: () => const _EventDetailContent(isLoading: true, detail: null),
      error: (e, _) =>
          _ErrorView(onRetry: () => ref.invalidate(eventDetailProvider(id))),
      data: (detail) => _EventDetailContent(isLoading: false, detail: detail),
    );
  }
}

class _EventDetailContent extends StatelessWidget {
  final bool isLoading;
  final EventDetailData? detail;

  const _EventDetailContent({required this.isLoading, required this.detail});

  List<MediaSource> get _carouselItems {
    if (isLoading || detail == null || detail!.media.isEmpty) {
      return List.generate(3, (_) => NetworkMedia(url: '', isVideo: false));
    }

    return detail!.media.map((m) {
      return NetworkMedia(
        url: m.url,
        title: detail?.event.name,
        isVideo: false,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final event = detail?.event;

    return Skeletonizer(
      effect: customShimmerEffect(context),
      enabled: isLoading,
      child: DetailPageWrapper(
        carousel: ContentCarousel(
          items: _carouselItems,
          isLoading: isLoading,
          aspectRatio: 1,
        ),
        headerChildren: FHeader.nested(
          prefixes: [
            FButton.icon(
              style: FButtonStyle.secondary(),
              onPress: () => context.pop(),
              child: const Icon(Icons.arrow_back, size: 24),
            ),
          ],
          suffixes: [
            FavoriteButton(eventId: detail?.event.id),
          ],
        ),
        bodyChildren: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                event?.name ?? 'Nome do Evento Carregando',
                style: context.theme.typography.xl2.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                runSpacing: 6,
                spacing: 6,
                children: (event?.categories ?? ['Evento', 'Categoria'])
                    .map(
                      (tag) => FBadge(
                        style: FBadgeStyle.secondary(),
                        child: Text(
                          tag,
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
                    ? 'Este é um texto de exemplo para o skeleton ocupar espaço na tela enquanto os dados reais estão sendo carregados...'
                    : (event?.description ?? 'Sem descrição disponível.'),
              ),
              const FDivider(),
              Column(
                spacing: 12,
                children: [
                  FButton(
                    onPress: () {
                      /* Lógica de contato */
                    },
                    child: const Text('Mais Informações'),
                  ),
                ],
              ),
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
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 16,
          children: [
            Icon(
              Icons.error_outline,
              color: context.theme.colors.mutedForeground,
              size: 64,
            ),
            Text(
              'Erro ao carregar evento',
              style: context.theme.typography.base,
            ),
            FButton(onPress: onRetry, child: const Text('Tentar novamente')),
          ],
        ),
      ),
    );
  }
}
