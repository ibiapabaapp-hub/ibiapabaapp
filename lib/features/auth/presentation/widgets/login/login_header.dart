import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:ibiapabaapp/shared/ui/sheet_drag_indicator.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SheetDragIndicator(),
        const SizedBox(height: 24),
        const Text(
          'Login',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 24),
        FButton(
          onPress: () {},
          style: FButtonStyle.outline(),
          prefix: Image.asset('assets/images/google-g-logo.webp', width: 18),
          child: const Text(
            "Continuar com Google",
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
