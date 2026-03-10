import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:ibiapabaapp/shared/ui/fragments/carousel/carousel_dot_indicator.dart';
import 'package:ibiapabaapp/shared/ui/fragments/media/content_media.dart';
import 'package:ibiapabaapp/shared/ui/fragments/media/sources.dart';

class ContentCarousel extends StatefulWidget {
  final List<MediaSource> items;
  final bool isLoading;
  final double aspectRatio;

  const ContentCarousel({
    super.key,
    required this.items,
    this.isLoading = false,
    this.aspectRatio = 16 / 18,
  });

  @override
  State<ContentCarousel> createState() => _ContentCarouselState();
}

class _ContentCarouselState extends State<ContentCarousel> {
  int activeIndex = 0;
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading || widget.items.isEmpty) {
      return AspectRatio(
        aspectRatio: widget.aspectRatio,
        child: Container(color: context.theme.colors.muted),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isTablet = constraints.maxWidth > 600;
        final double viewportFraction = isTablet ? 0.85 : 1.0;

        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 550),
            child: AspectRatio(
              aspectRatio: isTablet ? 16 / 9 : widget.aspectRatio,
              child: Stack(
                children: [
                  CarouselSlider.builder(
                    carouselController: _carouselController,
                    itemCount: widget.items.length,
                    itemBuilder: (context, index, realIndex) {
                      final item = widget.items[index];

                      // Pre-fetching lógico:
                      // O ContentMedia do próximo índice será instanciado,
                      // mas com isPlaying: false. O video_player pode
                      // começar o buffering silencioso se implementarmos isso nele.

                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: isTablet ? 8.0 : 0.0,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                            isTablet ? 16 : 0,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              if (item.route != null) context.push(item.route!);
                              // Próximo passo: adicionar abertura da Galeria FullScreen aqui
                            },
                            child: ContentMedia(
                              source: item,
                              isPlaying: activeIndex == index,
                              isVideo:
                                  item.isVideo,
                            ),
                          ),
                        ),
                      );
                    },
                    options: CarouselOptions(
                      height: double.infinity,
                      viewportFraction: viewportFraction,
                      autoPlay: widget.items.length > 1,
                      autoPlayInterval: const Duration(
                        seconds: 7,
                      ), // Aumentado para dar tempo de ver vídeos
                      pauseAutoPlayOnTouch: true,
                      enlargeCenterPage: isTablet,
                      enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                      enableInfiniteScroll: widget.items.length > 1,
                      onPageChanged: (index, reason) {
                        setState(() => activeIndex = index);
                      },
                    ),
                  ),

                  // Indicadores (Dots)
                  if (widget.items.length > 1)
                    Positioned(
                      bottom: 16,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: CarouselDotIndicator(
                          activeIndex: activeIndex,
                          itemsLength: widget.items.length,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
