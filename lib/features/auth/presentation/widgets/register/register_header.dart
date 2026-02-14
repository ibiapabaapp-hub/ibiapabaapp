import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class RegisterHeader extends StatelessWidget {
  const RegisterHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Text(
          'Cadastro',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
        Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
          style: TextStyle(fontSize: 14),
        ),
        SizedBox(height: 12),
        FButton(
          onPress: () {},
          style: FButtonStyle.secondary(),
          prefix: Image.asset('assets/images/google-g-logo.webp', width: 16),
          child: Text("Entrar com Google", style: TextStyle(fontSize: 14)),
        ),
      ],
    );
  }
}
