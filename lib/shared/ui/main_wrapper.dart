import 'package:flutter/material.dart';

class MainWrapper extends StatelessWidget {
  final List<Widget> children;
  const MainWrapper({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: .fromLTRB(24, 0, 24, 32),
      child: Column(spacing: 24, children: children),
    );
  }
}
