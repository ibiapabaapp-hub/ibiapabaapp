class Slide {
  final String title;
  final String description;
  final String imageAssetUri;

  Slide({
    required this.title,
    required this.description,
    required this.imageAssetUri,
  });
}

final List<Slide> carouselSlides = [
  Slide(
    title: 'Onde é hoje?',
    description:
        'Descubra o que há de melhor na Ibiapaba em poucos toques, aproveite promoções e saiba em primeira mão sobre eventos do seu interesse.',
    imageAssetUri: 'assets/images/highlights-1.webp',
  ),
  Slide(
    title: 'Lorem Ipsum Dolor',
    description:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    imageAssetUri: 'assets/images/highlights_placeholder.png',
  ),
];
