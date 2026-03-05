import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:ibiapabaapp/shared/ui/fragments/carousel/content_carousel.dart';
import 'package:ibiapabaapp/shared/ui/fragments/effects/default_shimmer_effect.dart';
import 'package:ibiapabaapp/shared/ui/fragments/effects/expandable_text.dart';
import 'package:ibiapabaapp/shared/ui/layout/section_header.dart';
import 'package:ibiapabaapp/shared/ui/layout/wrappers/detail_page_wrapper.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CityDetailScreen extends StatefulWidget {
  final String id;
  const CityDetailScreen({super.key, required this.id});

  @override
  State<CityDetailScreen> createState() => _CityDetailScreenState();
}

class _CityDetailScreenState extends State<CityDetailScreen> {
  bool _isLoading = true;

  late final List<ContentItem> _defaultItems = [
    ContentItem(
      type: ContentType.image,
      source: ContentSource.network,
      url:
          'https://imgs.search.brave.com/N4w28VWC72gH2Zi0HYc7q3-sUFkeDmsxHuZtLw7rakc/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly93d3cu/dmlhamFsaS5jb20u/YnIvd3AtY29udGVu/dC91cGxvYWRzLzIw/MjIvMDQvc2VycmEt/ZGEtaWJpYXBhYmEt/OS5qcGc',
    ),
    ContentItem(
      type: ContentType.image,
      source: ContentSource.network,
      url:
          'https://imgs.search.brave.com/N4w28VWC72gH2Zi0HYc7q3-sUFkeDmsxHuZtLw7rakc/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly93d3cu/dmlhamFsaS5jb20u/YnIvd3AtY29udGVu/dC91cGxvYWRzLzIw/MjIvMDQvc2VycmEt/ZGEtaWJpYXBhYmEt/OS5qcGc',
    ),
    ContentItem(
      type: ContentType.image,
      source: ContentSource.network,
      url:
          'https://imgs.search.brave.com/N4w28VWC72gH2Zi0HYc7q3-sUFkeDmsxHuZtLw7rakc/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly93d3cu/dmlhamFsaS5jb20u/YnIvd3AtY29udGVu/dC91cGxvYWRzLzIw/MjIvMDQvc2VycmEt/ZGEtaWJpYXBhYmEt/OS5qcGc',
    ),
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) setState(() => _isLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      effect: customShimmerEffect(context),
      enabled: _isLoading,
      child: DetailPageWrapper(
        carousel: ContentCarousel(items: _defaultItems, isLoading: _isLoading),
        headerChildren: FHeader.nested(
          prefixes: [
            FButton.icon(
              style: FButtonStyle.secondary(),
              onPress: () => context.pop(),
              child: Icon(Icons.arrow_back, size: 24),
            ),
          ],

          suffixes: [
            Skeletonizer(
              effect: customShimmerEffect(context),
              enabled: _isLoading,
              child: FavoriteButton(),
            ),
          ],
        ),

        bodyChildren: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.id,
                style: context.theme.typography.xl2.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),

              Wrap(
                runSpacing: 6,
                spacing: 6,
                children: [
                  FBadge(
                    style: FBadgeStyle.secondary(),
                    child: Skeleton.ignore(
                      child: Text(
                        widget.id,
                        style: context.theme.typography.sm.copyWith(
                          fontWeight: .normal,
                        ),
                      ),
                    ),
                  ),
                  FBadge(
                    style: FBadgeStyle.secondary(),
                    child: Skeleton.ignore(
                      child: Text(
                        'Cidades',
                        style: context.theme.typography.sm.copyWith(
                          fontWeight: .normal,
                        ),
                      ),
                    ),
                  ),
                  FBadge(
                    style: FBadgeStyle.secondary(),
                    child: Skeleton.ignore(
                      child: Text(
                        'Alto da Serra',
                        style: context.theme.typography.sm.copyWith(
                          fontWeight: .normal,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              ExpandableText(
                text: _isLoading
                    ? 'Este é um texto de exemplo para o skeleton ocupar espaço na tela, Este é um texto de exemplo para o skeleton ocupar espaço na tela'
                    : 'A cidade de Ubajara destaca-se pela rica geologia com grutas calcárias, formações rochosas e cavernas do Parque Nacional de Ubajara. O relevo serrano, aliado às paisagens únicas, torna o destino referência em ecoturismo e geoturismo no Nordeste.',
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

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({super.key});

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool userHasFavourited = false;

  @override
  Widget build(BuildContext context) {
    return FButton.icon(
      style: FButtonStyle.secondary(),

      onPress: () => setState(() => userHasFavourited = !userHasFavourited),

      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 150),

        transitionBuilder: (Widget child, Animation<double> animation) {
          return ScaleTransition(
            scale: CurvedAnimation(parent: animation, curve: Curves.bounceOut),

            child: FadeTransition(opacity: animation, child: child),
          );
        },

        child: Icon(
          userHasFavourited
              ? Icons.favorite_rounded
              : Icons.favorite_outline_rounded,

          key: ValueKey<bool>(userHasFavourited),

          size: 24,

          color: userHasFavourited
              ? context.theme.colors.primary
              : context.theme.colors.foreground,
        ),
      ),
    );
  }
}
