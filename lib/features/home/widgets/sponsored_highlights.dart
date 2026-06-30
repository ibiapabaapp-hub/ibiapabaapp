import 'package:flutter/material.dart';
import 'package:ibivibe/shared/ui/fragments/carousel/content_carousel.dart';
import 'package:ibivibe/shared/ui/fragments/media/sources.dart';

class SponsoredHighlights extends StatelessWidget {
  const SponsoredHighlights({super.key});

  static final List<MediaSource> _items = [
    NetworkMedia(
      url: 'https://cdn.ibivibe.com.br/cities/ubajara.png',
      route: '/app/cities/ubajara',
      title: 'Ubajara',
      isVideo: false,
    ),
    NetworkMedia(
      url: 'https://cdn.ibivibe.com.br/cities/tiangua.png',
      route: '/app/cities/tiangua',
      title: 'Tianguá',
      isVideo: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const .symmetric(horizontal: 16),
      child: Center(
        child: SizedBox(
          width: .infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: ContentCarousel(items: _items, aspectRatio: 3 / 2),
          ),
        ),
      ),
    );
  }
}
