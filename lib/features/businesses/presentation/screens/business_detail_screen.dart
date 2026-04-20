import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:ibiapabaapp/features/businesses/domain/entities/business_detail_data.dart';
import 'package:ibiapabaapp/features/businesses/presentation/controllers/business_detail_controller.dart';
import 'package:ibiapabaapp/shared/ui/fragments/carousel/content_carousel.dart';
import 'package:ibiapabaapp/shared/ui/fragments/effects/default_shimmer_effect.dart';
import 'package:ibiapabaapp/shared/ui/fragments/effects/expandable_text.dart';
import 'package:ibiapabaapp/shared/ui/fragments/media/sources.dart';
import 'package:ibiapabaapp/shared/ui/layout/section_header.dart';
import 'package:ibiapabaapp/shared/ui/layout/wrappers/detail_page_wrapper.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BusinessDetailScreen extends ConsumerWidget {
  final String id;
  const BusinessDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailAsync = ref.watch(businessDetailProvider(id));

    return detailAsync.when(
      loading: () =>
          const _BusinessDetailContent(isLoading: true, detail: null),
      error: (e, _) =>
          _ErrorView(onRetry: () => ref.invalidate(businessDetailProvider(id))),
      data: (detail) =>
          _BusinessDetailContent(isLoading: false, detail: detail),
    );
  }
}

class _BusinessDetailContent extends StatelessWidget {
  final bool isLoading;
  final BusinessDetailData? detail;

  const _BusinessDetailContent({required this.isLoading, required this.detail});

  // Mapeamento simplificado para MediaSource
  List<MediaSource> get _carouselItems {
    if (isLoading || detail == null || detail!.media.isEmpty) {
      // Retornamos uma lista vazia ou itens mock para o Skeletonizer
      return List.generate(3, (_) => NetworkMedia(url: '', isVideo: false));
    }

    return detail!.media.map((m) {
      return NetworkMedia(
        url: m.url,
        title: detail?.business.name,
        isVideo: false,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final business = detail?.business;

    return Skeletonizer(
      effect: customShimmerEffect(context),
      enabled: isLoading,
      child: DetailPageWrapper(
        // Passamos a lista de MediaSource para o carrossel
        carousel: ContentCarousel(items: _carouselItems, isLoading: isLoading),
        headerChildren: FHeader.nested(
          prefixes: [
            FButton.icon(
              style: FButtonStyle.secondary(),
              onPress: () => context.pop(),
              child: const Icon(Icons.arrow_back, size: 24),
            ),
          ],
          suffixes: [const FavoriteButton()],
        ),
        bodyChildren: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                business?.name ?? 'Carregando empresa',
                style: context.theme.typography.xl2.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                runSpacing: 6,
                spacing: 6,
                children:
                    (business?.categories ?? ['Categoria', 'Subcategoria'])
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
                    : (business?.bio ?? 'Sem descrição disponível.'),
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
          Text(
            'Erro ao carregar empresa',
            style: context.theme.typography.base,
          ),
          FButton(onPress: onRetry, child: const Text('Tentar novamente')),
        ],
      ),
    );
  }
}

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({super.key});

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool _favourited = false;

  @override
  Widget build(BuildContext context) {
    return FButton.icon(
      style: FButtonStyle.secondary(),
      onPress: () => setState(() => _favourited = !_favourited),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 150),
        transitionBuilder: (child, animation) => ScaleTransition(
          scale: CurvedAnimation(parent: animation, curve: Curves.bounceOut),
          child: FadeTransition(opacity: animation, child: child),
        ),
        child: Icon(
          _favourited ? Icons.favorite_rounded : Icons.favorite_outline_rounded,
          key: ValueKey<bool>(_favourited),
          size: 24,
          color: _favourited
              ? context.theme.colors.primary
              : context.theme.colors.foreground,
        ),
      ),
    );
  }
}
