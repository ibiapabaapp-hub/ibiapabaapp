import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:ibiapabaapp/features/welcome/widgets/welcome_slides.dart';

class WelcomeCarousel extends StatefulWidget {
  const WelcomeCarousel({super.key});

  @override
  State<WelcomeCarousel> createState() => _WelcomeCarouselState();
}

class _WelcomeCarouselState extends State<WelcomeCarousel> {
  final CarouselSliderController carouselController =
      CarouselSliderController();

  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Column(
      spacing: 16,
      children: [
        CarouselSlider.builder(
          controller: carouselController,
          itemCount: carouselSlides.length,
          options: CarouselOptions(
            scrollPhysics: ClampingScrollPhysics(),
            disableCenter: true,
            initialPage: 0,
            height: 400,
            pageSnapping: true,
            enableInfiniteScroll: false,
            enlargeCenterPage: false,
            enlargeStrategy: .scale,
            onPageChanged: (index, reason) {
              setState(() => activeIndex = index);
            },
          ),
          itemBuilder: (context, index, realIndex) {
            final slide = carouselSlides[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Image.asset(slide.imageAssetUri),
            );
          },
        ),

        AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          transitionBuilder: (child, animation) {
            final offset = Tween<double>(
              begin: 0.3,
              end: 1,
            ).animate(CurvedAnimation(parent: animation, curve: Curves.easeIn));

            return FadeTransition(
              opacity: animation,
              child: FadeTransition(opacity: offset, child: child),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              key: ValueKey(activeIndex),
              spacing: 12,
              children: [
                Text(
                  carouselSlides[activeIndex].title,
                  style: theme.typography.xl2.copyWith(fontWeight: .w600),
                  textAlign: .center,
                ),
                Text(
                  carouselSlides[activeIndex].description,
                  style: theme.typography.sm,
                  textAlign: .center,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
