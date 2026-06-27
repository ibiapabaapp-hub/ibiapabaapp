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
    description: 'Descubra o que há de melhor na Ibiapaba em poucos toques',
    imageAssetUri: 'assets/images/highlights-1.webp',
  ),
  Slide(
    title: 'Recomendações com base em seus interesses',
    description:
        'Priorizamos os empreendimentos e eventos que te interessam para recomendações certeiras usando Inteligência Artificial',
    imageAssetUri: 'assets/images/highlights_placeholder.png',
  ),
  Slide(
    title: 'Anuncie no lugar e hora certos',
    description:
        'Traga sua empresa para nosso catálogo e anuncie diretamente para quem realmente te procura - no momento certo',
    imageAssetUri: 'assets/images/highlights_placeholder.png',
  ),
];
