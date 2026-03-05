import 'package:flutter/material.dart';

class DetailPageWrapper extends StatelessWidget {
  final Widget headerChildren;
  final Widget carousel;
  final List<Widget> bodyChildren;

  const DetailPageWrapper({
    super.key,
    required this.carousel,
    required this.headerChildren,
    required this.bodyChildren,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: .start,
          spacing: 24,
          children: [
            Stack(
              alignment: .topCenter,
              children: [
                Column(children: [carousel]),
                headerChildren,
              ],
            ),
            Container(
              padding: .symmetric(horizontal: 24),
              child: Column(crossAxisAlignment: .start, children: bodyChildren),
            ),
          ],
        ),
      ),
    );
  }
}
