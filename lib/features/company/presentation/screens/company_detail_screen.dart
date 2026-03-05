import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:ibiapabaapp/shared/ui/fragments/carousel/content_carousel.dart';
import 'package:ibiapabaapp/features/company/presentation/widgets/rating_section.dart';
import 'package:ibiapabaapp/shared/ui/fragments/effects/default_shimmer_effect.dart';
import 'package:ibiapabaapp/shared/ui/fragments/effects/expandable_text.dart';
import 'package:ibiapabaapp/shared/ui/layout/wrappers/detail_page_wrapper.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CompanyDetailScreen extends StatefulWidget {
  final String id;
  const CompanyDetailScreen({super.key, required this.id});

  @override
  State<CompanyDetailScreen> createState() => _CompanyDetailScreenState();
}

class _CompanyDetailScreenState extends State<CompanyDetailScreen> {
  bool _isLoading = true;
  late final List<ContentItem> _defaultItems = [
    ContentItem(
      type: ContentType.image,
      source: ContentSource.network,
      url:
          'https://instagram.fphb1-1.fna.fbcdn.net/v/t51.29350-15/420956110_349782431205505_1471574166258709716_n.webp?stp=dst-jpg_e35_tt6&efg=eyJ2ZW5jb2RlX3RhZyI6IkNBUk9VU0VMX0lURU0uaW1hZ2VfdXJsZ2VuLjEwODB4MTM1MC5zZHIuZjI5MzUwLmRlZmF1bHRfaW1hZ2UuYzIifQ&_nc_ht=instagram.fphb1-1.fna.fbcdn.net&_nc_cat=101&_nc_oc=Q6cZ2QHrsI7-mDIxw_Qmc3O1p4_RVre4hWyGHyCgn45hEP6b5q4F3JXBV8mcqXnZxFnuSxw&_nc_ohc=Tfcj7OnoJO4Q7kNvwGvNnrH&_nc_gid=2KDcfuetBNUICmPBcsRHiw&edm=APoiHPcBAAAA&ccb=7-5&ig_cache_key=MzI4NjY0Mjg5NTc5MTgwNTk2NA%3D%3D.3-ccb7-5&oh=00_AfvrT6GVYzpjmLtQkni4rRAiC-a56ivEXZKz9Rp9tP5nUA&oe=699F004E&_nc_sid=22de04',
    ),
    ContentItem(
      type: ContentType.image,
      source: ContentSource.network,
      url:
          'https://instagram.fphb1-1.fna.fbcdn.net/v/t51.29350-15/439569282_307935569004116_9155144152332534415_n.webp?stp=dst-jpg_e35_tt6&efg=eyJ2ZW5jb2RlX3RhZyI6IkNBUk9VU0VMX0lURU0uaW1hZ2VfdXJsZ2VuLjg2NHgxMDgwLnNkci5mMjkzNTAuZGVmYXVsdF9pbWFnZS5jMiJ9&_nc_ht=instagram.fphb1-1.fna.fbcdn.net&_nc_cat=108&_nc_oc=Q6cZ2QGfZd2hxNfUWZNQH7mlR-ynVoaB3uBhadeouwYOCX_vzGoP5eFpIDlGD6KQDDBdfR8&_nc_ohc=yOrs0NQ5qCEQ7kNvwGwuVy5&_nc_gid=qH8ZHS5bNu9h3qUQkkndgg&edm=APoiHPcBAAAA&ccb=7-5&ig_cache_key=MzM1MjYwMzk5MzMwMDUwOTI5Nw%3D%3D.3-ccb7-5&oh=00_Afv_lySjV5TQVtAmUk0fKG0JtTBLGzabz7wUmpWgb1aeow&oe=699EFB01&_nc_sid=22de04',
    ),
    ContentItem(
      type: ContentType.image,
      source: ContentSource.network,
      url:
          'https://instagram.fphb1-1.fna.fbcdn.net/v/t51.29350-15/420375204_1435177483700022_3584013566615479562_n.webp?stp=dst-jpg_e35_tt6&efg=eyJ2ZW5jb2RlX3RhZyI6IkNBUk9VU0VMX0lURU0uaW1hZ2VfdXJsZ2VuLjEwODB4MTM1MC5zZHIuZjI5MzUwLmRlZmF1bHRfaW1hZ2UuYzIifQ&_nc_ht=instagram.fphb1-1.fna.fbcdn.net&_nc_cat=106&_nc_oc=Q6cZ2QHrsI7-mDIxw_Qmc3O1p4_RVre4hWyGHyCgn45hEP6b5q4F3JXBV8mcqXnZxFnuSxw&_nc_ohc=BBXosDhZ2uEQ7kNvwGlzcWS&_nc_gid=2KDcfuetBNUICmPBcsRHiw&edm=APoiHPcBAAAA&ccb=7-5&ig_cache_key=MzI4NjY0Mjg5NTgwMDEzOTc0OQ%3D%3D.3-ccb7-5&oh=00_AfueH-2Zy3qAfTdg2JHI5bY-6Ip9QiagwLtSQgLhx9BrZA&oe=699EFE7D&_nc_sid=22de04',
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
                'Restaurante Manacá da Serra',
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
                      child: Row(
                        spacing: 4,
                        children: [
                          Icon(
                            Icons.diamond_outlined,
                            color: context.theme.colors.primary,
                            size: 16,
                          ),

                          Text(
                            'Autoridade',
                            style: context.theme.typography.sm.copyWith(
                              fontWeight: .normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  FBadge(
                    style: FBadgeStyle.secondary(),
                    child: Skeleton.ignore(
                      child: Text(
                        'Restaurantes',
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
                        'Tianguá',
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
                    : 'Celebre a vida, reúna família e amigos em saborosos encontros!🌻\n\nTerça-feira à Domingo\n\nAlmoço 11h-15h | Jantar 18h-23h30',
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
              Text('TODO: Comentários'),
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
