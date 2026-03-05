import 'package:flutter/material.dart';
import 'package:ibiapabaapp/shared/ui/fragments/carousel/content_carousel.dart';

class SponsoredHighlights extends StatefulWidget {
  const SponsoredHighlights({super.key});

  @override
  State<SponsoredHighlights> createState() => _SponsoredHighlightsState();
}

enum ImageItemSourceType { asset, network }

class ImageItem {
  final String? title;
  final String assetUrl;
  final ImageItemSourceType sourceType;

  ImageItem({this.title, required this.assetUrl, required this.sourceType});
}

class _SponsoredHighlightsState extends State<SponsoredHighlights> {
  int activeIndex = 0;

  final List<ContentItem> _items = [
    ContentItem(
      type: .image,
      source: .network,
      url:
          'https://instagram.fjdo10-1.fna.fbcdn.net/v/t51.82787-15/619274405_17932095936169278_9113178893503771846_n.jpg?stp=dst-jpg_e35_tt6&_nc_cat=102&ig_cache_key=MzgxNTcwMjMyMDU4NDI1NDIwOQ%3D%3D.3-ccb7-5&ccb=7-5&_nc_sid=58cdad&efg=eyJ2ZW5jb2RlX3RhZyI6InhwaWRzLjEzNDd4MTY3OS5zZHIuQzMifQ%3D%3D&_nc_ohc=Aqmq0VcUj00Q7kNvwGW_3yI&_nc_oc=Adk59Yq6XcxK43LG7PhxZN-rxet_RjjtlAj_hAZ_Vpq5-ej2dnLCz309WXYzvWHctXpE0TqO4EpQbZbMa8yFQ5DG&_nc_ad=z-m&_nc_cid=0&_nc_zt=23&_nc_ht=instagram.fjdo10-1.fna&_nc_gid=oyYpeGPvc3efwquyHNHfWA&oh=00_AfvKfCH_xjwZOZySns1Axal11wiOFTd7hcgu4KB4bTGoPQ&oe=69A4E906',
      route: '/app/companies/1',
    ),
    ContentItem(
      type: .image,
      source: .network,
      url:
          'https://instagram.fjdo10-1.fna.fbcdn.net/v/t51.82787-15/634077920_17872584768540232_8046203275083850636_n.jpg?stp=dst-jpg_e35_tt6&_nc_cat=102&ig_cache_key=MzgzNTI3MzU1Mzg3MzU0NjkwMQ%3D%3D.3-ccb7-5&ccb=7-5&_nc_sid=58cdad&efg=eyJ2ZW5jb2RlX3RhZyI6InhwaWRzLjEwNDB4MTMwMC5zZHIuQzMifQ%3D%3D&_nc_ohc=ujMkhqShJoQQ7kNvwH24qg7&_nc_oc=AdnTrmt3KAwjaXz8Adg18CDmjLFROzJyrsE_vOQ-bQerG11rfU3iN1a--ZAGhCHT72zfv54HR1QpE5TlcQrIAlHG&_nc_ad=z-m&_nc_cid=0&_nc_zt=23&_nc_ht=instagram.fjdo10-1.fna&_nc_gid=pM0bb7qQxpmnr6ST9mMV_w&oh=00_AfuApBauTXCYceEYev7FQQ9qi_ShApBhR3B2xuVmwgQumQ&oe=69A4CF68',
      route: '/app/events/2',
    ),
    ContentItem(
      type: .image,
      source: .network,
      url:
          'https://instagram.fjdo1-2.fna.fbcdn.net/v/t39.30808-6/615806104_1505684451118692_7931494716238578524_n.jpg?stp=dst-jpg_e35_tt6&_nc_cat=100&ig_cache_key=MzgxMDE3MTkxMjY1Njc2NDYwNg%3D%3D.3-ccb7-5&ccb=7-5&_nc_sid=58cdad&efg=eyJ2ZW5jb2RlX3RhZyI6InhwaWRzLjEwODB4MTM1MC5zZHIuQzMifQ%3D%3D&_nc_ohc=r-pgxV_tePkQ7kNvwFqkZPp&_nc_oc=AdmOn-VZCNzMjHu8qKBT-pLFKpuUCtc2m96deCsZ4iiQtdLglHInyQX75VK6TfqhxmOJPAaQwMoAH60nPolxytMl&_nc_ad=z-m&_nc_cid=0&_nc_zt=23&_nc_ht=instagram.fjdo1-2.fna&_nc_gid=iTI15amYO5VOM6Am6W01OQ&oh=00_AfsbQC_tCUBRs5GHIhU3tO1bBMaWTXph1VPUKyTqkNFgGA&oe=69A4DDF9',
      route: '/app/events/3',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 450,
      child: AspectRatio(
        aspectRatio: 5 / 6,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: ContentCarousel(items: _items),
        ),
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
