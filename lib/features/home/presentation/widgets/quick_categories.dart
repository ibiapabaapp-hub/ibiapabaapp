import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class QuickCategoriesList extends StatelessWidget {
  final List<String> _categories = [
    'Restaurantes',
    'Hotéis e Pousadas',
    'Postos de Gasolina',
    'Banhos',
    'Comércio',
    'Aventura',
  ];

  QuickCategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const .fromLTRB(24, 0, 0, 0),
      child: SizedBox(
        height: 40,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          physics: const ClampingScrollPhysics(),
          itemCount: _categories.length,
          separatorBuilder: (_, _) => const SizedBox(width: 6),
          itemBuilder: (context, index) {
            return FButton(
              onPress: () {},
              style: FButtonStyle.secondary(),
              child: Text(
                _categories.elementAt(index),
                style: TextStyle(fontSize: 14),
              ),
            );
          },
        ),
      ),
    );
  }
}
