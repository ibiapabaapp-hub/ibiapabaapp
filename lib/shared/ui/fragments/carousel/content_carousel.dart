import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:ibiapabaapp/shared/ui/fragments/carousel/carousel_dot_indicator.dart';
import 'package:skeletonizer/skeletonizer.dart';

enum ContentType { image, video }

enum ContentSource { asset, network }

class ContentItem {
  final String url;
  final ContentType type;
  final ContentSource source;
  final String? title;
  final String? route;

  ContentItem({
    required this.url,
    required this.type,
    required this.source,
    this.title,
    this.route,
  });
}

class ContentMedia extends StatelessWidget {
  final ContentItem? item;
  final bool isLoading;

  const ContentMedia({super.key, this.item, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    if (isLoading || item == null) {
      return Container(
        width: double.infinity,
        height: double.infinity,
        color: context.theme.colors.muted,
      );
    }

    if (item!.type == ContentType.video) {
      return _buildVideoPlaceholder();
    }

    return _buildImage();
  }

  Widget _buildImage() {
    return item!.source == ContentSource.asset
        ? Image.asset(item!.url, fit: BoxFit.cover, width: double.infinity)
        : Image.network(
            item!.url,
            fit: BoxFit.cover,
            width: double.infinity,
            errorBuilder: (_, _, _) => const Icon(Icons.broken_image),
          );
  }

  Widget _buildVideoPlaceholder() {
    return Skeleton.replace(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(color: Colors.black),
          const Icon(Icons.play_circle_fill, size: 50, color: Colors.white70),
        ],
      ),
    );
  }
}

class ContentCarousel extends StatefulWidget {
  final List<ContentItem> items;
  final bool isLoading;

  const ContentCarousel({
    super.key,
    required this.items,
    this.isLoading = false,
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
    final displayItems = widget.isLoading
        ? [
            ContentItem(
              url: '',
              type: ContentType.image,
              source: ContentSource.asset,
            ),
          ]
        : widget.items;

    return AspectRatio(
      aspectRatio: 16 / 18,
      child: Stack(
        children: [
          CarouselSlider.builder(
            carouselController: _carouselController,
            itemCount: displayItems.length,
            itemBuilder: (context, index, _) => GestureDetector(
              onTap: () {
                if (displayItems[index].route != null) {
                  context.push(displayItems[index].route!);
                }
              },
              child: ContentMedia(
                item: widget.isLoading ? null : displayItems[index],
                isLoading: widget.isLoading,
              ),
            ),
            options: CarouselOptions(
              height: double.infinity,
              viewportFraction: 1.0,
              autoPlay: !widget.isLoading && displayItems.length > 1,
              enableInfiniteScroll: false,
              onPageChanged: (index, _) {
                if (!widget.isLoading) setState(() => activeIndex = index);
              },
            ),
          ),

          // Indicadores (Dots)
          Positioned(
            bottom: 12,
            left: 0,
            right: 0,
            child: Center(
              child: Skeleton.ignore(
                ignore: widget.isLoading,
                child: CarouselDotIndicator(
                  activeIndex: activeIndex,
                  itemsLength: displayItems.length,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class _SponsoredLabel extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//       decoration: BoxDecoration(
//         color: context.theme.colors.primary,
//         borderRadius: BorderRadius.circular(6),
//       ),
//       child: Row(
//         mainAxisAlignment: .center,
//         crossAxisAlignment: .center,
//         children: [
//           Icon(
//             Icons.campaign,
//             size: 24,
//             color: context.theme.colors.primaryForeground,
//           ),
//           Text(
//             '2° Trilhão Tianguá Offroad',
//             style: TextStyle(
//               fontWeight: .w600,
//               fontSize: 16,
//               color: context.theme.colors.primaryForeground,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
