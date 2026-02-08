import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class City {
  final String name;
  final String? description;

  City({required this.name, this.description});
}

class ExploreCitiesSection extends StatelessWidget {
  const ExploreCitiesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<City> cities = [
      City(name: 'Ubajara'),
      City(name: 'Tianguá'),
      City(name: 'São Benedito'),
      City(name: 'Viçosa do Ceará'),
      City(name: 'Ver mais...'),
    ];

    return Column(
      mainAxisAlignment: .start,
      crossAxisAlignment: .start,
      spacing: 16,
      children: [
        Text(
          "Explore as cidades da Ibiapaba",
          style: TextStyle(fontSize: 18, fontWeight: .w600),
          strutStyle: StrutStyle(leading: 1.2),
        ),
        SizedBox(
          height: 280,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const ClampingScrollPhysics(),
            separatorBuilder: (_, _) => const SizedBox(width: 6),
            itemCount: cities.length,
            itemBuilder: (context, index) => FCard.raw(
              style: (style) => style.copyWith(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: context.theme.colors.secondary,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: .start,
                  crossAxisAlignment: .start,
                  spacing: 12,
                  children: [
                    Text(
                      cities.elementAt(index).name,
                      style: TextStyle(fontSize: 18, fontWeight: .w600),
                    ),
                    Expanded(child: Placeholder(fallbackWidth: 240)),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
