import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class SheetHeader extends StatelessWidget {
  const SheetHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Alterar localização',
          style: context.theme.typography.lg.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.settings_outlined),
          onPressed: () {},
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
      ],
    );
  }
}
