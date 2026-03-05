import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:ibiapabaapp/shared/ui/fragments/carousel/content_carousel.dart';
import 'package:ibiapabaapp/features/company/presentation/widgets/rating_section.dart';
import 'package:ibiapabaapp/shared/ui/fragments/effects/default_shimmer_effect.dart';
import 'package:ibiapabaapp/shared/ui/fragments/comments/comment.dart';
import 'package:ibiapabaapp/shared/ui/fragments/comments/comment_list.dart';
import 'package:ibiapabaapp/shared/ui/fragments/effects/expandable_text.dart';
import 'package:ibiapabaapp/shared/ui/layout/wrappers/detail_page_wrapper.dart';
import 'package:skeletonizer/skeletonizer.dart';

class EventDetailScreen extends StatefulWidget {
  final String id;
  const EventDetailScreen({super.key, required this.id});

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  bool _isLoading = true;

  late final List<ContentItem> _defaultItems = [
    ContentItem(
      type: .image,
      source: .asset,
      url: 'assets/images/banner-trilhao-quadrado.webp',
    ),
    ContentItem(
      type: .image,
      source: .network,
      url:
          'https://ramilos-comunicacoes.github.io/trilhao/assets/images/gallery/foto-1.jpg',
    ),
    ContentItem(
      type: .video,
      source: .network,
      url:
          'https://ramilos-comunicacoes.github.io/trilhao/assets/images/videos/video-2.mp4',
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
              onPress: context.pop,
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
                        'Evento',
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
                        'Aberto ao público',
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
                        'Esportivo',
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
                    : 'Uma experiência única que desafia os limites de homens e máquinas. Percorrendo os caminhos mais radicais entre as cidades de Tianguá, Ubajara e Viçosa do Ceará, essa trilha se tornou o maior evento off-road da região Nordeste. \n\nCom mais de 120km de percurso off-road, o evento reúne centenas de participantes e milhares de espectadores, movimentando a economia local e promovendo o turismo de aventura.',
              ),

              const FDivider(),

              Column(
                spacing: 12,
                children: [
                  FButton(onPress: () {}, child: const Text('Contato')),
                  FButton(
                    style: FButtonStyle.ghost(),
                    onPress: () {},
                    child: const Text('Horário de funcionamento'),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              RatingSection(averageRating: 4.7, ratingQuantity: 16),
              const SizedBox(height: 12),

              CommentList(
                comments: [
                  CommentItem(
                    userName: 'Júnior Alonso',
                    text: 'Ótimo restaurante, não existe outro igual na Serra!',
                    ratingGiven: 5.0,
                  ),
                  CommentItem(
                    userName: 'Mariazinha',
                    text: 'Não tive uma boa experiência',
                    ratingGiven: 2.0,
                  ),
                ],
              ),

              const SizedBox(height: 24),

              Text('TODO: Recomendações parecidas'),
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
